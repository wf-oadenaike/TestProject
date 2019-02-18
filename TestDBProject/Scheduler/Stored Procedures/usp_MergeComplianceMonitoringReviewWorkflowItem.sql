CREATE PROCEDURE [Scheduler].[usp_MergeComplianceMonitoringReviewWorkflowItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON	

	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_MergeComplianceMonitoringReviewWorkflowItem',
			@RunDate DATE,
			@MonitoringCategoryId INT,
			@MonitoringFrequency VARCHAR(128),
			@FrequencyStartMonth VARCHAR(128),
			@FlowId UNIQUEIDENTIFIER,
			@NextDate DATE,
			@LaunchDate DATE;

	DECLARE @NewData TABLE ( FlowId VARCHAR(100),LaunchDate DATE,LaunchRef VARCHAR(255));
		
	SET @RunDate = GETDATE()
	
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Compliance Monitoring Review'
					);

	DECLARE CategoriesCursor CURSOR FOR
		SELECT    MonitoringCategoryId
				, MonitoringFrequency
				, FrequencyStartMonth
		FROM [Compliance].[MonitoringCategories];

	OPEN CategoriesCursor;
	FETCH NEXT FROM CategoriesCursor
	INTO @MonitoringCategoryId, @MonitoringFrequency, @FrequencyStartMonth;

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		IF @MonitoringFrequency = 'Monthly'
				SET @NextDate = DATEADD(Month,1,@RunDate)
		ELSE IF @MonitoringFrequency = 'Quarterly'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				WHILE @NextDate < @RunDate
					SET @NextDate = DATEADD(Month,3,@NextDate)			
			END
		ELSE IF @MonitoringFrequency = 'Tri-Annually'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				WHILE @NextDate < @RunDate
					SET @NextDate = DATEADD(Month,4,@NextDate)
			END
		ELSE IF @MonitoringFrequency = 'Semi-Annually'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				WHILE @NextDate < @RunDate
					SET @NextDate = DATEADD(Month,6,@NextDate)
			END
		ELSE IF @MonitoringFrequency = 'Annually'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				IF @NextDate < @RunDate
				   SET @NextDate = DATEADD(Year,1,@NextDate)
			END
		
		SET @LaunchDate = DATEADD(WEEK, DATEDIFF(WEEK, 0,DATEADD(DAY, 6 - DATEPART(DAY, @NextDate), @NextDate)), 0)
		
		INSERT INTO @NewData(FlowId,LaunchDate,LaunchRef)
		VALUES (@FlowId, @LaunchDate, 'MonitoringCategoryId:' + CAST(@MonitoringCategoryId as varchar));

		FETCH NEXT FROM CategoriesCursor
		INTO @MonitoringCategoryId, @MonitoringFrequency, @FrequencyStartMonth;
		
	END

	CLOSE CategoriesCursor;
	DEALLOCATE CategoriesCursor;
	
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
				,  REPLACE(LaunchList.LaunchRef,'MonitoringCategoryId:','') AS Value
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

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
END CATCH
;
