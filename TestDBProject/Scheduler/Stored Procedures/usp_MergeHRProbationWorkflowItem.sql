

CREATE PROCEDURE [Scheduler].[usp_MergeHRProbationWorkflowItem]
 @EmployeeID VARCHAR(20),
 @ActiveFromDate Date

AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strProcedureName		VARCHAR(100)	= '[Scheduler].[usp_MergeHRProbationWorkflowItem]';	
	
	DECLARE @NewData TABLE ( FlowId VARCHAR(100),LaunchDate DATE,LaunchRef VARCHAR(255),EmployeeID VARCHAR(20));

	INSERT INTO @NewData(FlowId,LaunchDate,LaunchRef,EmployeeID)
	SELECT 
		WF.FlowId,
		CONVERT(DATE,@ActiveFromDate,103)  AS LaunchDate,
		'String filled by scheduler:'+ @EmployeeID AS LaunchRef, 
		@EmployeeID as EmployeeID
	FROM [Scheduler].[Workflows] WF 
	WHERE WF.FlowName='HR Probation Monitoring'
	;

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
			AND Tar.LaunchRef = Src.LaunchRef)
	WHEN NOT MATCHED 
		THEN INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
			 VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive)
	;

	MERGE INTO [Scheduler].[WorkflowParameters] WFP
	USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'String filled by scheduler' as KeyName
				, NEW.EmployeeID AS Value
				, 'ContentString' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] LaunchList
			INNER JOIN @NewData NEW
			ON NEW.LaunchRef = LaunchList.LaunchRef
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