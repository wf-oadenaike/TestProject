
CREATE PROCEDURE [Scheduler].[usp_CreateFundManagerSignOffScheduleItem]
 
AS
BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_CreateFundManagerSignOffScheduleItem',
			@RetrievalDate DATE,
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE,
			@LaunchRef VARCHAR(100);

	DECLARE @ClientID INT,
			@ValuationDate DATE,
			@action VARCHAR(10),
			@WorkFlowLaunchId INT;
	
	-- run on sunday, so force to sat. Want previous friday or next monday
	SET @RetrievalDate = DATEADD(d,-1,GETDATE());
	
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Fund Manager Sign-off this week'
					);
					
	DECLARE FundManagerSignOffCursor CURSOR FOR
		SELECT DISTINCT ClientId,
			   DATEADD(d,CASE WeeklyValuationSignOffDay WHEN 'Monday' THEN 0
                                                 WHEN 'Tuesday' THEN 1
												 WHEN 'Wednesday' THEN 2
												 WHEN 'Thursday' THEN 3
												 WHEN 'Friday' THEN 4 ELSE 0 END ,DATEADD(week, DATEDIFF(week, 0, @RetrievalDate), 0)) as ValuationDate
	FROM [Investment].[Mandates]
	WHERE ISNULL([IsWeeklyReconciliation],0) = 1
	;

	OPEN FundManagerSignOffCursor;
	FETCH NEXT FROM FundManagerSignOffCursor
	INTO @ClientID, @ValuationDate;

	WHILE @@FETCH_STATUS = 0
		BEGIN

		-- for each result, create schedule if one doesnt already exist for the MandateId for yesterday so runs straight away
		
		SET @LaunchDate = @RetrievalDate;
		SET @LaunchRef = 'ClientId:' + CAST(@ClientID as varchar);
		
		-- IF valuation date in the past and is a monday add 7 days
		IF DATENAME(weekday,@ValuationDate) = 'Monday' AND @ValuationDate < CAST(GetDate() as date) SET @ValuationDate = DATEADD(d,7,@ValuationDate);
		
	    MERGE INTO Scheduler.WorkflowLaunchList Tar
	    USING (
				SELECT @FlowId as FlowId,
				       @LaunchDate as LaunchDate,
				       @LaunchRef as LaunchRef,
					   1 as IsActive
		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchRef = Src.LaunchRef
			AND CAST(Tar.LaunchDate as Date) = CAST(Src.LaunchDate as Date))
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
					
		MERGE INTO [Scheduler].[WorkflowParameters] WFP
		USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Date filled by scheduler' as KeyName
				,  CONVERT(Varchar,@ValuationDate,121) + 'T00:00:00' AS Value
				, 'ContentDateTime' as ContentType
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
			
		FETCH NEXT FROM FundManagerSignOffCursor
			INTO  @ClientID, @ValuationDate;
		
	END

	CLOSE FundManagerSignOffCursor;
	DEALLOCATE FundManagerSignOffCursor;
	
			
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

