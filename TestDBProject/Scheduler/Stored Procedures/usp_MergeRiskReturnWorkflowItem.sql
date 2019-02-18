CREATE PROCEDURE [Scheduler].[usp_MergeRiskReturnWorkflowItem]
 
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strProcedureName		VARCHAR(100)	= 'Scheduler.usp_MergeRiskReturnWorkflowItem',
			@RetrievalDate DATE,
			@FlowId UNIQUEIDENTIFIER,
			@LaunchDate DATE,
			@LaunchRef VARCHAR(255);

	SET @RetrievalDate = GETDATE()		
			
	SET @FlowId = ( SELECT FlowId
				    FROM [Scheduler].[Workflows] 
				    WHERE FlowName='Risk Return Flow'
					);

	-- select next risk return meeting
	
	SET @LaunchDate = ( SELECT DATEADD(D,-10,mo.[MeetingDateTime])
						FROM [Organisation].[MeetingOccurrence] mo
						INNER JOIN [Organisation].[MeetingsRegister] mr
						ON mo.[MeetingRegisterId] = mr.[MeetingRegisterId]
						WHERE mr.[MeetingNameBK] = 'Risk Committee'
						AND mo.[MeetingDateTime] = (SELECT MIN(mo1.[MeetingDateTime]) FROM [Organisation].[MeetingOccurrence] mo1
													WHERE mo1.[MeetingRegisterId] = mo.[MeetingRegisterId]
													AND mo1.[MeetingDateTime] >= @RetrievalDate) )
	;	
	
						
	
	SET @LaunchRef = 'Risk_Return_DT:'+ CONVERT(VARCHAR(10), @LaunchDate, 112);
	
	-- make future workflow items inactive before we start because meeting and hence launch date may have changed
	
	UPDATE Scheduler.WorkflowLaunchList 
	SET IsActive = 0
	WHERE FlowId = @FlowId
	AND LaunchDate >= @RetrievalDate
	AND IsActive = 1
	;
	
	MERGE INTO Scheduler.WorkflowLaunchList Tar
	USING (
			SELECT 
				@FlowId as FlowId,
				@LaunchDate as LaunchDate,
				@LaunchRef AS LaunchRef,
				1 AS IsActive,
				GETDATE() AS CreatedDate

		 ) Src
			ON ( Tar.FlowId = Src.FlowId 
			AND Tar.LaunchDate = Src.LaunchDate
			AND Tar.LaunchRef = Src.LaunchRef )
	WHEN NOT MATCHED 
		THEN INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
			 VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	WHEN MATCHED
		THEN UPDATE SET IsActive = Src.IsActive
	;

  MERGE INTO [Scheduler].[WorkflowParameters] wfp
  USING ( 
		  SELECT LaunchList.[WorkflowLaunchId]
               , 'Risk_Return_DT' as KeyName
		       ,  REPLACE(LaunchList.LaunchRef,'Risk_Return_DT:','') AS Value
			   , 'ContentString' as ContentType
		  FROM [Scheduler].[WorkflowLaunchList] LaunchList
		  WHERE LaunchList.LaunchRef = @LaunchRef
		  AND LaunchList.LaunchDate = @LaunchDate
		  AND LaunchList.FlowId = @FlowId
		) Src
  ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
  AND wfp.[Value] = Src.[Value]
  WHEN NOT MATCHED THEN 
		INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
		VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] )
				;			
	
			
END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
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
