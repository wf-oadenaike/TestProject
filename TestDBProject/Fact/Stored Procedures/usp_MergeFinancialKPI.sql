CREATE PROCEDURE [Fact].[usp_MergeFinancialKPI]
		@ControlId BIGINT=-1
AS
/*-------------------------------------------------------------------------------------- 
 Name:			Fact.usp_MergeFinancialKPI

 Note:			Procedure update Fact.FinancialsFact table for only financials KPI_ID's
 
 Author:		FI
 Date:			04/09/2015
------------------------------------------------------------------------------------ 
 Date			ModifiedBy		Details
 30/11/2015		FI				Corrected the source and Target table join in merge
-- ------------------------------------------------------------------------------------*/

BEGIN TRY

	SET NOCOUNT ON

	DECLARE @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	DECLARE	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_MergeFinancialKPI]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	-- Populate two different FinancialLineTypeId's for KPI_ID 790 & 793 
	CREATE TABLE #FinancialTypes
	(
	KPIID INT,
	FinancialLineTypeId SMALLINT
	)
	INSERT INTO #FinancialTypes (KPIID, FinancialLineTypeId) VALUES (790,7);
	INSERT INTO #FinancialTypes (KPIID, FinancialLineTypeId) VALUES (790,8);
	INSERT INTO #FinancialTypes (KPIID, FinancialLineTypeId) VALUES (793,7);
	INSERT INTO #FinancialTypes (KPIID, FinancialLineTypeId) VALUES (793,8);

	--SELECT * FROM Fact.FinancialsFact where ControlId=20150904140111


	MERGE INTO Fact.FinancialsFact TARGET
			USING ( 
					SELECT 
						1 AS DepartmentId, 
						C.CalendarId AS PostingDateId,
						C.CalendarId AS TransactionDateId, 
						ActualValue AS BudgetAmount, 
						-1 as VendorId, 
						-1 as PersonId, 
						--KD.KPIIDBK,
						S.SourceSystemId, 
						 
						CASE 
							WHEN KD.KPIIDBK = 799 THEN 6
							WHEN KD.KPIIDBK = 791 THEN 7
							ELSE F.FinancialLineTypeId
						END AS FinancialLineTypeId,
						-1 AS TransactionNo,
						@ControlId as ControlId, 
						---1 as TransactionTypeId,
						--CountOf,
						--1 AS CurrentRow,
						---1 AS CurrentRowSwitchId
						
						CASE 
							WHEN KD.KPIIDBK = 790 THEN 7000
							WHEN KD.KPIIDBK = 791 THEN 7001
							WHEN KD.KPIIDBK = 793 THEN 7006
							WHEN KD.KPIIDBK = 799 THEN 4000
						END AS NominalCode
				FROM [Staging.KPI].[KPIData] KD
				INNER JOIN [Core].[Calendar] C
				ON KD.KPIDataDate = C.CalendarDate
				LEFT OUTER JOIN #FinancialTypes F
				ON F.KPIID = KD.KPIIDBK
				CROSS JOIN Audit.SourceSystems S
				WHERE KD.KPIIDBK IN (790,791,793,799)
				AND S.SourceSystemCode = 'SKPI'
				
				) AS Src
			ON ( 
					TARGET.PostingDateId = Src.PostingDateId
				AND TARGET.TransactionDateId = Src.TransactionDateId
				AND TARGET.FinancialLineTypeId = Src.FinancialLineTypeId
				AND TARGET.NominalCode = Src.NominalCode
				)
			WHEN NOT MATCHED BY TARGET
				THEN INSERT (
								DepartmentId, 
								PostingDateId, 
								TransactionDateId, 
								BudgetAmount, 
								ControlId, 
								SourceSystemId, 
								FinancialLineTypeId, 
								--[TaxCode]
								--TransactionTypeId, 
								NominalCode
							)
					 VALUES (
								Src.DepartmentId, 
								Src.PostingDateId, 
								Src.TransactionDateId,
								Src.BudgetAmount, 
								Src.ControlId, 
								Src.SourceSystemId,
								Src.FinancialLineTypeId, 
								--Src.TransactionTypeId, 
								Src.NominalCode
							)
			WHEN MATCHED AND(
							TARGET.BudgetAmount <> Src.BudgetAmount
			
							)
			THEN UPDATE SET TARGET.BudgetAmount = Src.BudgetAmount
							, TARGET.ControlId  = Src.ControlId
			--OUTPUT $action, inserted.*
			;

			DROP TABLE #FinancialTypes
	--SET @InsertRowCount = @@ROWCOUNT;

END TRY
BEGIN CATCH
		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		SELECT	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RAISERROR (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		RETURN @ErrorNumber;
END CATCH
