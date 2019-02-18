CREATE PROCEDURE [Scheduler].[usp_MergeClientReportingWorkflowItem]

/*

	D.Bacchus	09-05-2017	DAP-1030 added ISACTIVE to where clause
	
*/
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	BEGIN TRANSACTION

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_MergeClientReportingWorkflowItem',
			@RunDate DATE,
			@ClientReportingId INT,
			@ReportingFrequency VARCHAR(128),
			@FrequencyStartDay INT,
			@FrequencyStartMonth VARCHAR(128),
			@FlowId UNIQUEIDENTIFIER,
			@NextDate DATE,
			@LaunchDate DATE;

	DECLARE @NewData TABLE ( FlowId VARCHAR(100),LaunchDate DATE,LaunchRef VARCHAR(255));
		
	SET @RunDate = GETDATE()
	
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Client reporting - jira tasks'
					);

	DECLARE ReportingCursor CURSOR FOR
		SELECT    ClientReportingId
				, ReportingFrequency
				, FrequencyStartDay
				, FrequencyStartMonth
		FROM [Sales].[ClientReporting]
		WHERE IsActive = 1;

	OPEN ReportingCursor;
	FETCH NEXT FROM ReportingCursor
	INTO @ClientReportingId, @ReportingFrequency, @FrequencyStartDay, @FrequencyStartMonth;

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		IF @ReportingFrequency = 'Monthly'
				SET @NextDate = DATEADD(M,1,@RunDate)
		ELSE IF @ReportingFrequency = 'Quarterly'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				WHILE @NextDate < @RunDate
					SET @NextDate = DATEADD(Month,3,@NextDate)			
			END

		ELSE IF @ReportingFrequency = 'Semi-Annually'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				WHILE @NextDate < @RunDate
					SET @NextDate = DATEADD(Month,6,@NextDate)
			END

        -- get @ReportingStartDay day of current month by starting from last day of previous month		
		SET @LaunchDate = DATEADD(d,@FrequencyStartDay,EOMONTH(@NextDate,-1))
		
		INSERT INTO @NewData(FlowId,LaunchDate,LaunchRef)
		VALUES (@FlowId, @LaunchDate, 'ClientReportingId:' + CAST(@ClientReportingId as varchar));

		FETCH NEXT FROM ReportingCursor
		INTO @ClientReportingId, @ReportingFrequency, @FrequencyStartDay, @FrequencyStartMonth;
		
	END

	CLOSE ReportingCursor;
	DEALLOCATE ReportingCursor;
	
	-- now merge into scheduler
	-- this will only create one future entry for each category
	
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT 
				NEW.FlowId,
				NEW.LaunchDate,
				NEW.LaunchRef,
				1 AS IsActive,
				GETDATE() AS CreatedDate
				FROM @NewData NEW

		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.LaunchDate >= GetDate())
	WHEN NOT MATCHED THEN 
	INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
	VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	WHEN MATCHED THEN
	        UPDATE SET  LaunchDate = Src.LaunchDate
			          , IsActive = 1
	;

	MERGE INTO [Scheduler].[WorkflowParameters] WFP
	USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Number filled by scheduler' as KeyName
				,  REPLACE(LaunchList.LaunchRef,'ClientReportingId:','') AS Value
				, 'ContentNumber' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] LaunchList
			INNER JOIN @NewData NEW
			ON NEW.FlowId = LaunchList.FlowId
			AND NEW.LaunchRef = LaunchList.LaunchRef
			AND NEW.LaunchDate = LaunchList.LaunchDate
		) Src
	ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
	AND wfp.[Value] = Src.[Value]
	WHEN NOT MATCHED THEN 
	INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
	VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] );	
	
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

