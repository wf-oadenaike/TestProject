CREATE PROCEDURE [Fact].[usp_MergeForecasts]
		@ControlId BIGINT=-1
AS
/*-------------------------------------------------------------------------------------- 
 Name:		 Fact.usp_MergeForecasts
 
 Note:			
 
 Author:		Faheem
 Date:			16/09/2015
-------------------------------------------------------------------------------------- 
History:			 
DATE			Author				DESC
16/09/2015		FI					Initial Write		
21/09/2015		FI					Modified AccountHierarchyId join on AccountName to get correct id
20/11/2015		FI					Added restriction for Expenses not to get parent AccountHierarchyId
05/02/2016      RC             		Correct DepartmentNumber logic to allow loading of future financial years
20/03/2017		RC					Add Dept 20 Business Change

-------------------------------------------------------------------------------------- */

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_MergeForecasts]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	WITH Src 
		AS (	SELECT 
						d.DepartmentId, 
						c.CalendarId as TransactionDateId, 
						BudgetAmount, 
						s.SourceSystemId
						, CASE pd.FiscalYear 
								WHEN 20142015 THEN fltB.FinancialLineTypeId
								ELSE flt.FinancialLineTypeId 
							END AS FinancialLineTypeId
						, pd.NominalCode
						, pd.IsExpense
				FROM (
						SELECT FinancialLineCode, DepartmentNumber, Account,SUBACCOUNT, FiscalYear, NominalCode, BudgetMonth, Cast( replace( BudgetAmount,',','') as Decimal(19,2)) as BudgetAmount,IsExpense
						FROM
							( 
								SELECT db.FinancialLineCode, DepartmentNumber, FiscalYear, NominalCode, Heading2 AS Account
									, COALESCE(TRY_CAST(db.AprilCol as money),0) as [01], COALESCE(TRY_CAST(db.MayCol as money),0) as [02], 
									  COALESCE(TRY_CAST(db.JunCol as money),0) as [03], COALESCE(TRY_CAST(db.JuLCol as money),0) as [04], COALESCE(TRY_CAST(db.AugCol as money),0) as [05]
									, COALESCE(TRY_CAST(db.SepCol as money),0) as [06], COALESCE(TRY_CAST(db.OctCol as money),0) as [07], 
									COALESCE(TRY_CAST(db.NovCol as money),0) as [08], COALESCE(TRY_CAST(db.DecCol as money),0) as [09], COALESCE(TRY_CAST(db.JanCol as money),0) as [10]
									, COALESCE(TRY_CAST(db.FebCol as money),0) as [11], COALESCE(TRY_CAST(db.MarCol as money),0) as [12],db.Heading3 AS SUBACCOUNT, db.IsExpense
								
								FROM [Staging].[BudgetDept-Data]  db 
								WHERE NominalCode IS NOT NULL
								AND (
								COALESCE(TRY_CAST(db.AprilCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.MayCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.JunCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.JulCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.AugCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.SepCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.OctCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.NovCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.DecCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.JanCol as money),0)<>0
								OR COALESCE(TRY_CAST(db.FebCol as money),0)<>0
								OR 	COALESCE(TRY_CAST(db.MarCol as money),0)<>0)		
								-- Cast( db.AprilCol as money) <>0 or Cast( db.MayCol as money) <>0 or Cast( db.JunCol as money) <>0 
								--OR Cast( db.JulCol as money) <>0 or Cast( db.AugCol as Money) <>0 or Cast( db.SepCol as Money) <>0
								--OR Cast( db.OctCol as Money) <>0 or Cast( db.NovCol as Money) <>0 or Cast( db.DecCol as Money) <>0 
								--OR Cast( db.JanCol as Money) <>0 or Cast( db.FebCol as Money) <>0 or Cast( db.MarCol as Money) <>0)
								AND ((DepartmentNumber IN (0,1,2,3,5,6,7,8,9,10,11,12,13,14,20)
									AND FiscalYear != 20142015) 
									OR (DepartmentNumber IN (1,2,3,5,6,7,8,9,10,11,12,13,14,20) 
									AND FiscalYear = 20142015))
							) DataSource
							UNPIVOT
								(BudgetAmount for BudgetMonth IN
								([01], [02], [03], [04], [05], [06], [07], [08], [09], [10], [11], [12])
								) as UnPivotData
					) pd
				INNER JOIN Core.Departments d
					on (pd.DepartmentNumber = d.DepartmentNumber)
				INNER JOIN Finance.FinancialLineTypes flt
					on (pd.FinancialLineCode = flt.FinancialLineCode)
				INNER JOIN (SELECT c.FiscalYear, c.FiscalMonth, min([CalendarId]) as CalendarId
							FROM [Core].[Calendar] c
							GROUP BY c.FiscalYear, c.FiscalMonth) c
					on ( pd.FiscalYear = c.FiscalYear
					AND pd.BudgetMonth = c.FiscalMonth)	
				INNER JOIN [Finance].[AccountNominalCodes] AS anc ON anc.NominalCode = pd.NominalCode
				CROSS JOIN Audit.SourceSystems s
				CROSS JOIN Finance.FinancialLineTypes fltB
				Where s.SourceSystemCode = 'WFF'
				AND fltB.FinancialLineCode = 'F'
		
			)



		MERGE INTO Fact.FinancialsFact Target
		USING ( SELECT Src.DepartmentId, Src.TransactionDateId, 
						(CASE WHEN Src.IsExpense = 0 AND Src.NominalCode >=4300 THEN ABS(Src.BudgetAmount) ELSE ABS(Src.BudgetAmount) END) AS BudgetAmount,
						 Src.SourceSystemId, Src.FinancialLineTypeId, NominalCode
						, @ControlId as ControlId, -1 as VendorId, -1 as PersonId, -1 as TransactionTypeId
				FROM Src
			) as Src
		ON ( Target.DepartmentId = Src.DepartmentId
		AND Target.PostingDateId = Src.TransactionDateId
		AND Target.TransactionDateId = Src.TransactionDateId
		AND Target.FinancialLineTypeId = Src.FinancialLineTypeId
		AND Target.TransactionTypeId = -1
		AND Target.FinancialLineTypeId = Src.FinancialLineTypeId
		AND Target.NominalCode = Src.NominalCode 
		AND Target.CurrentRow = 1
		AND Target.DeletedRow = 0
		AND Target.TransactionNo = -1
		)
		WHEN NOT MATCHED BY TARGET
			THEN INSERT (DepartmentId, PostingDateId, TransactionDateId, BudgetAmount, ControlId
						, SourceSystemId, FinancialLineTypeId, TransactionTypeId, NominalCode,
						TransactionNo)
				 VALUES (Src.DepartmentId, Src.TransactionDateId, Src.TransactionDateId,
						Src.BudgetAmount, Src.ControlId, Src.SourceSystemId,
						Src.FinancialLineTypeId, Src.TransactionTypeId, Src.NominalCode,
						-1)
		WHEN MATCHED AND (Target.BudgetAmount <> Src.BudgetAmount)
			THEN UPDATE SET BudgetAmount = Src.BudgetAmount
							,ControlId=Src.ControlId
		OUTPUT $action, inserted.*
		;

	--SET @InsertRowCount = @@ROWCOUNT;

	--SELECT @ProcessRowCount AS ProcessRowCount
	--	, @InsertRowCount AS InsertRowCount
	--	, @UpdateRowCount AS UpdateRowCount
	--	, @DeleteRowCount AS DeleteRowCount
	--	;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH
