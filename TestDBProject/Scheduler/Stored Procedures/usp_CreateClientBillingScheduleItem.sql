CREATE PROCEDURE [Scheduler].[usp_CreateClientBillingScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	BEGIN TRANSACTION

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateClientBillingScheduleItem',
			@NextDate DATE,
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE,
			@LaunchRef VARCHAR(100);

	DECLARE @ClientId INT,
			@action VARCHAR(10),
			@BillingFrequency VARCHAR(128),
			@FrequencyStartMonth VARCHAR(25),
			@WorkFlowLaunchId INT;
		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Client Billing Task'
					);

	DECLARE ClientCursor CURSOR FOR
		SELECT ClientId
		     , BillingFrequency
			 , FrequencyStartMonth
	    FROM [Sales].[ClientRegister]
	    WHERE ISNULL([IsActive],0) = 1
		AND BillingFrequency IS NOT NULL
	;

	OPEN ClientCursor;
	FETCH NEXT FROM ClientCursor
	INTO @ClientId, @BillingFrequency, @FrequencyStartMonth;

	WHILE @@FETCH_STATUS = 0
		BEGIN

		-- for each result, create schedule for next billing task for each Client

		SET @NextDate = GetDate()
			
		IF @BillingFrequency = 'Monthly'
				SET @NextDate = DATEADD(M,1,@NextDate)
		ELSE IF @BillingFrequency = 'Quarterly'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@NextDate) as varchar) AS DATE)
				
				WHILE @NextDate <= GetDate()
					SET @NextDate = DATEADD(Month,3,@NextDate)			
			END

        -- get @ReportingStartDay first day of month by starting from last day of previous month		
		SET @LaunchDate = DATEADD(d,1,EOMONTH(@NextDate,-1));
		SET @LaunchRef = 'ClientId:' + CAST(@ClientId as varchar);
		
		
	    MERGE INTO Scheduler.WorkflowLaunchList Tar
	    USING (
				SELECT @FlowId as FlowId,
				       @LaunchDate as LaunchDate,
				       @LaunchRef as LaunchRef,
					   1 as IsActive
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND CAST(Tar.LaunchDate as Date) = CAST(@LaunchDate as Date))
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
		;
							
		MERGE INTO [Scheduler].[WorkflowParameters] WFP
		USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Number filled by scheduler' as KeyName
				,  CAST(@ClientId as Varchar) AS Value
				, 'ContentNumber' as ContentType
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
			
		FETCH NEXT FROM ClientCursor
		INTO @ClientId, @BillingFrequency, @FrequencyStartMonth;
		
	END

	CLOSE ClientCursor;
	DEALLOCATE ClientCursor;
	
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
