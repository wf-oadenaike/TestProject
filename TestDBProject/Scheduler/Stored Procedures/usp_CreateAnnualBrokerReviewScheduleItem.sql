CREATE PROCEDURE [Scheduler].[usp_CreateAnnualBrokerReviewScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	BEGIN TRANSACTION

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateAnnualBrokerReviewScheduleItem',
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE;

		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Broker Annual Review'
					);
					

	SET @LaunchDate = GetDate()
			
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT @FlowId as FlowId,
				   @LaunchDate as LaunchDate,
				   'Broker Annual Review' as LaunchRef,
					1 as IsActive
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND CAST(Tar.LaunchDate as Date) = CAST(@LaunchDate as Date))
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive);

	
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
