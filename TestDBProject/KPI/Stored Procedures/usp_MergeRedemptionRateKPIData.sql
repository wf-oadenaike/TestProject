

CREATE PROCEDURE [KPI].[usp_MergeRedemptionRateKPIData]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[KPI].[usp_MergeRedemptionRateKPIData]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			14/04/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;
	SET DATEFORMAT dmy;

	BEGIN TRANSACTION

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[KPI].[usp_MergeRedemptionRateKPIData]';
	DECLARE @SourceSystemId INT
	SELECT @SourceSystemId = SourceSystemId FROM [Audit].[SourceSystems] WHERE SourceSystemCode = 'WFMI'

	DECLARE @ControlId BIGINT
	SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))

	SET DateFormat dmy;

	MERGE INTO [Fact].[KPIFact] Tar
	USING (
		SELECT 
			[CalendarId] as [MeasureDateId], 
			KpiId, 
			(CASE WHEN SUM(ISNULL(Subscriptions,0)) = 0 THEN 1 ELSE SUM(ABS(ISNULL(Redemptions,0))) / SUM(ISNULL(Subscriptions,0)) END) AS [MeasureValue], 
			MAX(LastUpdated) AS LastUpdated
		FROM(
			SELECT 
				[CalendarId]
				,kpi.KPIId
				,(CASE WHEN VALUE > 0 THEN VALUE END) AS Subscriptions
				,(CASE WHEN VALUE < 0 THEN VALUE END) AS Redemptions
				,d.[CADIS_SYSTEM_LASTMODIFIED] AS LastUpdated
			FROM 
				[dbo].[T_MASTER_DEALS_IN_PROGRESS] d
			INNER JOIN 
				[Core].[Calendar] c
						ON CONVERT( Date, [VALUATION_POINT],103) = c.CalendarDate
			INNER JOIN
				[KPI].[MeasuredKPIs] kpi ON 1 = 1 AND kpi.KPIBK = 754
			) data
		GROUP BY
			[CalendarId], KpiId
		) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId
	AND Tar.LastUpdatedDatetime = Src.[LastUpdated])
	WHEN NOT MATCHED
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [ControlId], [SourceSystemId],[LastUpdatedDatetime])
				VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], @ControlId, @SourceSystemId, Src.[LastUpdated])
    WHEN MATCHED AND Tar.MeasureValue <> Src.MeasureValue
		THEN UPDATE SET 
					 Tar.MeasureValue = Src.MeasureValue
					,Tar.ControlId =@ControlId
		;

	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
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

