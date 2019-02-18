CREATE PROCEDURE [Scheduler].[usp_CreateComplianceMonitoringScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateComplianceMonitoringScheduleItem',
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE;

		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Compliance Monitoring - Monthly EBI JIRA'
					);
	
	-- set to 1st day of next month
	SET @LaunchDate =  DATEADD(d, 1, EOMONTH(getdate()));
			
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT @FlowId as FlowId,
				   @LaunchDate as LaunchDate,
				   'Compliance Monitoring - Monthly EBI JIRA' as LaunchRef,
					1 as IsActive
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND CAST(Tar.LaunchDate as Date) = CAST(@LaunchDate as Date))
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive);

			
END TRY
BEGIN CATCH
		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
				
		--IF @@TRANCOUNT > 0 ROLLBACK;

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
