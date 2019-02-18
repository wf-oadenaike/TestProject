CREATE PROCEDURE [Scheduler].[usp_CreateChangeManagementScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateChangeManagementScheduleItem',
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE;

		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Change Management - Reminder Flow'
					);
	
	SET @LaunchDate = 
	CASE DATENAME(weekday,GetDate())
		WHEN 'Friday' THEN DATEADD(d,3,GetDate())
		WHEN 'Saturday' THEN DATEADD(d,2,GetDate())
		ELSE DATEADD(d,1,GetDate())
	END;
			
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT @FlowId as FlowId,
				   @LaunchDate as LaunchDate,
				   'Change Management Reminder' as LaunchRef,
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
