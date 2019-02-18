CREATE PROCEDURE [Fact].[usp_MergeKPIFact_MandatoryTraining]
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Fact].[usp_MergeKPIFact_MandatoryTraining]
-- 
-- Note:			
-- 
-- Author:			L Maher
-- Date:			17/10/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;

	BEGIN TRANSACTION

	Declare	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_MergeKPIFact_MandatoryTraining]';	

		Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		, @SourceSystemId int = (SELECT COALESCE(SourceSystemId,-1) FROM [Audit].[SourceSystems] WHERE [SourceSystemCode] = 'BBG')
		;

MERGE INTO [Fact].[KPIFact] Tar
	USING (

	SELECT
	convert(varchar(8),getdate(),112) AS [MeasureDateId]
	,(SELECT [KPIId]  FROM [KPI].[MeasuredKPIs] b WHERE b.[KPIDBBK] = 'MandAntiFinCrimeTrain') AS [KPIId] 
	,1 - CONVERT(DECIMAL(19,5),SUM(CASE WHEN COALESCE([ExpiryDate],'2000-01-01') < getdate() THEN 1 ELSE 0 END))/CONVERT(DECIMAL(19,5),COUNT(DISTINCT [EmployeeName])) AS [MeasureValue]
	,getdate() AS [LastUpdatedDatetime]
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','') AS [ControlId]
	FROM
	(
	SELECT  
	[EmployeeName]
	,[TrainingName]
	,MAX([ProposedDate]) AS ProposedDate
	--,[AttestationComplete]
	,MAX([ExpiryDate]) AS [ExpiryDate]
	  FROM [Compliance].[MandatoryTraining]
	  WHERE [TrainingName]LIKE '%CRIME%' 
	  AND [HRUserStatus]='Active'

	  GROUP BY [EmployeeName]
	,[TrainingName]
	--,[AttestationComplete]
	) a

) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId)
	WHEN NOT MATCHED
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [LastUpdatedDatetime], [ControlId], [SourceSystemId])
				VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], Src.[LastUpdatedDatetime], Src.[ControlId], @SourceSystemId)
    WHEN MATCHED AND Tar.MeasureValue <> Src.MeasureValue
		THEN UPDATE SET 
					 Tar.MeasureValue = Src.MeasureValue
					,Tar.ControlId = Src.[ControlId]
					,Tar.LastUpdatedDatetime = Src.[LastUpdatedDatetime]
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
