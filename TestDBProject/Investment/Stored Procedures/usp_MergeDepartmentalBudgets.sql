 
CREATE PROCEDURE [Investment].[usp_MergeDepartmentalBudgets]
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	BEGIN TRANSACTION

	DECLARE	@strProcedureName VARCHAR(100)	= 'Investment.usp_MergeDepartmentalBudgets';
	
	-- actuals
	MERGE INTO [Investment].[DepartmentalBudgets] Tar
	USING ( 
			SELECT  aff.DepartmentId, 
					SUM(ISNULL(aff.ActualAmount,0)) as ActualAmount, 			 
					cal.CalMonth,
					cal.CalYear
			FROM [Fact].[FinancialsFact] aff
			INNER JOIN [Core].[Calendar] cal
			ON aff.[TransactionDateId] = cal.[CalendarId]
			WHERE aff.[SourceSystemId] = 1 -- SAGE
			AND aff.[FinancialLineTypeId] = 1 -- A
			AND aff.CurrentRow=1
			AND aff.DeletedRow=0
			AND aff.NominalCode > 4300
			GROUP BY aff.DepartmentId, cal.CalMonth, cal.CalYear
		  
		  ) as Src
  ON (Tar.DepartmentId = Src.DepartmentId
  AND Tar.MonthNumber = Src.CalMonth
  AND Tar.CalendarYear = Src.CalYear)
  WHEN NOT MATCHED THEN
	INSERT (DepartmentId, MonthNumber, CalendarYear, ActualAmount, ForecastAmount)
	VALUES (Src.DepartmentId, Src.CalMonth, Src.CalYear, Src.ActualAmount, 0)
  WHEN MATCHED AND (Tar.ActualAmount != Src.ActualAmount) THEN
		UPDATE SET ActualAmount = Src.ActualAmount
				 , DepartmentalBudgetLastModifiedDatetime = GetDate()
				 
;

    -- forecasts
	MERGE INTO [Investment].[DepartmentalBudgets] Tar
	USING ( 
			SELECT  fff.DepartmentId, 
					SUM(CASE WHEN fff.NominalCode >= 4300 THEN ABS(ISNULL(fff.BudgetAmount,0)) ELSE ISNULL(fff.BudgetAmount,0) END ) as ForecastAmount, 				 
					cal.CalMonth,
					cal.CalYear
			FROM [Fact].[FinancialsFact] fff
			INNER JOIN [Core].[Calendar] cal
			ON fff.[TransactionDateId] = cal.[CalendarId]
			INNER JOIN [Core].[Departments] d
			ON fff.DepartmentId = d.DepartmentId
			WHERE fff.[SourceSystemId] = 4 -- WFF
			AND ((fff.[FinancialLineTypeId] = 7 AND fff.[TransactionDateId] < 20160401 AND d.DepartmentNumber != 13 ) -- ND/D combined before 01-apr-2016 except for digital
            OR  (fff.[FinancialLineTypeId] = 7 AND fff.[TransactionDateId] < 20150401 AND d.DepartmentNumber = 13 ) -- ND/D combined before 01-apr-2016  for digital
			OR  (fff.[FinancialLineTypeId] IN (7,8) AND fff.[TransactionDateId] BETWEEN 20150401 AND 20160331 AND d.DepartmentNumber = 13 ) -- for digital
			OR (fff.[FinancialLineTypeId] IN (7,8) AND fff.[TransactionDateId] >= 20160401 )) --ND/D split after 01-apr-2016
			AND fff.CurrentRow=1
			AND fff.DeletedRow=0
			
			GROUP BY fff.DepartmentId, cal.CalMonth, cal.CalYear
		  
		  ) as Src
  ON (Tar.DepartmentId = Src.DepartmentId
  AND Tar.MonthNumber = Src.CalMonth
  AND Tar.CalendarYear = Src.CalYear)
  WHEN NOT MATCHED THEN
	INSERT (DepartmentId, MonthNumber, CalendarYear, ActualAmount, ForecastAmount)
	VALUES (Src.DepartmentId, Src.CalMonth, Src.CalYear, 0, Src.ForecastAmount)
  WHEN MATCHED AND (Tar.ForecastAmount != Src.ForecastAmount) THEN
		UPDATE SET ForecastAmount = Src.ForecastAmount
				 , DepartmentalBudgetLastModifiedDatetime = GetDate()
				 
;	

	COMMIT TRANSACTION;
			
END TRY
BEGIN CATCH
		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
				
		IF @@TRANCOUNT > 0 ROLLBACK;

		SELECT	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
END CATCH
;
