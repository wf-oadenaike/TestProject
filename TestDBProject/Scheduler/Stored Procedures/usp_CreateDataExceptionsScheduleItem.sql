CREATE PROCEDURE [Scheduler].[usp_CreateDataExceptionsScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateDataExceptionsScheduleItem',
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE;

	DECLARE @WorkFlowLaunchId INT;
		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Data Exceptions task creation'
					);
	
	SET @LaunchDate = DATEADD(d,-1,GetDate());
			
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
		    SELECT @FlowId as FlowId,
				   @LaunchDate as LaunchDate,
				   'Data Exceptions' as LaunchRef,
				   1 as IsActive
		  ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.LaunchDate = Src.LaunchDate )
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
		;

			
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
