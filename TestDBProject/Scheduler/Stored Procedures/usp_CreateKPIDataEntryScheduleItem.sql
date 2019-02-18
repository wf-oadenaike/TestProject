
CREATE PROCEDURE [Scheduler].[usp_CreateKPIDataEntryScheduleItem]

/*

	D.Bacchus	09-05-2017	DAP-1030 for @FrequencyName = 'Weekly' the change the day from Friday to Monday

*/ 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateKPIDataEntryScheduleItem',
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE,
			@RunDate DATE,
			@NextDate DATE,
			@DataEntryPersonId INT,
			@FrequencyName varchar(20),
			@FrequencyStartMonth varchar(10),
			@LaunchRef varchar(100);

	DECLARE @action VARCHAR(10),
			@WorkFlowLaunchId INT;
		
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='KPI task creation'
					);
									  
	SET @FrequencyStartMonth = 'January';
	SET @RunDate = GetDate();
									  
	DECLARE DataEntryCursor CURSOR FOR
		SELECT DISTINCT def.[FrequencyName]
                      , mmde.[DataEntryPersonId]
        FROM [KPI].[MeasuredKPIManualDataEntry] mmde
	    INNER JOIN [Core].[Persons] p
		ON mmde.DataEntryPersonId = p.PersonId
	    INNER JOIN KPI.RefreshFrequency def
		ON mmde.DataEntryFrequencyId = def.RefreshFrequencyId
	    WHERE mmde.[IsActive] = 1
	    AND mmde.[DataEntryPersonId] != -1
		AND mmde.[DataEntryFrequencyId] != -1
	;

	OPEN DataEntryCursor;
	FETCH NEXT FROM DataEntryCursor
	INTO @FrequencyName, @DataEntryPersonId;
		
	WHILE @@FETCH_STATUS = 0
		BEGIN

		-- for each Data entry person for each frequency, create schedule
		-- frequencies Annually, Semi-Annually, Quarterly, Monthly, Weekly, Daily
						
		IF @FrequencyName = 'Monthly'
		    -- last day of current month
			SET @LaunchDate = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@RunDate)+1,0))
		ELSE IF @FrequencyName = 'Quarterly'
			BEGIN
			    -- start month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				WHILE @NextDate < @RunDate
					SET @NextDate = DATEADD(Month,3,@NextDate)		
					
				-- last day of current quarter
		        SET @LaunchDate = DATEADD(d,-1,@NextDate)				
			END
		ELSE IF @FrequencyName = 'Annually'
			BEGIN
			    -- start next month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				IF @NextDate < @RunDate
				   SET @NextDate = DATEADD(Year,1,@NextDate)
				   
				-- last day of current year
				SET @LaunchDate = DATEADD(d,-1, @NextDate)
			END
		ELSE IF @FrequencyName = 'Semi-Annually'
			BEGIN
			    -- start next month
				SET @NextDate = CAST(@FrequencyStartMonth + CAST(DATEPART(YEAR,@RunDate) as varchar) AS DATE)
				
				IF @NextDate < @RunDate
				   SET @NextDate = DATEADD(Month,6,@NextDate)
				   
				-- last day of previous half year
				SET @LaunchDate = DATEADD(d,-1, @NextDate)
			END
		ELSE IF @FrequencyName = 'Weekly'
			-- next Monday
			SET @LaunchDate = CAST(DATEADD(WEEK, DATEDIFF(WEEK, 0, @RunDate), 7) AS DATE)
	
		ELSE IF @FrequencyName = 'Daily'
			-- next weekday
			SET @LaunchDate = DATEADD(Day,1,@RunDate)
			
			SET @LaunchDate = (SELECT CASE DATENAME(dw,@LaunchDate) 
			                               WHEN 'Saturday' THEN DATEADD(Day,2,@LaunchDate)
										   WHEN 'Sunday' THEN DATEADD(Day,1,@LaunchDate)
									  ELSE @LaunchDate
									  END);
									  
		IF @FrequencyName NOT IN ('Daily','Weekly')
			-- put launch date back to previous week day if weekend
			SET @LaunchDate = (SELECT CASE DATENAME(dw,@LaunchDate) 
			                               WHEN 'Saturday' THEN DATEADD(Day,-1,@LaunchDate)
										   WHEN 'Sunday' THEN DATEADD(Day,-2,@LaunchDate)
									  ELSE @LaunchDate
									  END);			
		
		SET @LaunchRef = 'KPIDataEntry:' + CAST(@DataEntryPersonId as Varchar) + '-' + @FrequencyName;
		
	    MERGE INTO Scheduler.WorkflowLaunchList Tar
	    USING (
				SELECT @FlowId as FlowId,
				       @LaunchDate as LaunchDate,
				       @LaunchRef as LaunchRef,
					   1 as IsActive
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND Tar.LaunchDate = Src.LaunchDate )
		WHEN NOT MATCHED THEN 
		INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
		VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
		;
					
		MERGE INTO [Scheduler].[WorkflowParameters] WFP
		USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Number filled by scheduler' as KeyName
				,  CAST(@DataEntryPersonId as Varchar) AS Value
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

		MERGE INTO [Scheduler].[WorkflowParameters] WFP
		USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'String filled by scheduler' as KeyName
				,  @FrequencyName AS Value
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
				
		FETCH NEXT FROM DataEntryCursor
		INTO @FrequencyName, @DataEntryPersonId;
		
	END

	CLOSE DataEntryCursor;
	DEALLOCATE DataEntryCursor;
			
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
