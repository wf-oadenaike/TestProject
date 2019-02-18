
CREATE PROCEDURE [Scheduler].[usp_CreateClientBillingReconScheduleItem]

/*

	D. Bacchus	09-05-2017	DAP-1030: SET @LaunchDate = DATEADD(m, DATEDIFF(m, 0, GETDATE()), 20); Change the above command to set the Launch date to 15th
*/ 
AS
BEGIN TRY

	SET NOCOUNT ON

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateClientBillingReconScheduleItem',
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE,
			@LaunchMonthParameter varchar(10),
			@LaunchRef VARCHAR(100);

	DECLARE @ClientId INT,
			@action VARCHAR(10),
			@WorkFlowLaunchId INT;
		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Client Billing Reconciliation'
					);

        -- set Launch Date to 15th of the current month	
		SET @LaunchDate = DATEADD(m, DATEDIFF(m, 0, GETDATE()), 14);
		-- set Launch Month parameter MMM-YYYY for previous month (Billing Month)
		SET @LaunchMonthParameter = LEFT(DATENAME ( MONTH , DateAdd(m,-1,@LaunchDate) ),3) + ' ' + CAST(YEAR(DateAdd(m,-1,@LaunchDate)) AS CHAR(4));
		SET @LaunchRef = 'BillingMonth:' + @LaunchMonthParameter;
		
	    MERGE INTO Scheduler.WorkflowLaunchList Tar
	    USING (
				SELECT @FlowId as FlowId,
				       @LaunchDate as LaunchDate,
				       @LaunchRef as LaunchRef,
					   1 as IsActive
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.LaunchDate = @LaunchDate )
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
		;		
		
		MERGE INTO [Scheduler].[WorkflowParameters] WFP
		USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'String filled by scheduler' as KeyName
				,  @LaunchMonthParameter AS Value
				, 'ContentString' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] LaunchList
			WHERE LaunchList.FlowId = @FlowId
			AND LaunchList.LaunchRef = @LaunchRef
			AND LaunchList.LaunchDate = @LaunchDate
				) Src
			ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
			AND wfp.[Value] = Src.[Value]
			WHEN NOT MATCHED THEN 
				INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
				VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] );
			
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

