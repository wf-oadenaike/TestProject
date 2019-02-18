CREATE PROCEDURE [Scheduler].[usp_MergeRiskAppetiteWorkflowItem]
 
AS
BEGIN TRY
SET NOCOUNT ON

DECLARE	@strProcedureName VARCHAR(100)	= 'Scheduler.usp_MergeRiskAppetiteWorkflowItem';	

DECLARE @RunDate DATE	
Set @RunDate = GETDATE()
				

IF DATENAME(MONTH, @RunDate) IN ('December','June')
BEGIN	
	DECLARE @NewData TABLE ( FlowId VARCHAR(100),LaunchDate DATE,LaunchRef VARCHAR(255));
	
	DECLARE @dt DATE
	
	SET @dt =(
				SELECT  CONVERT(DATE,DATEADD(Month, DATEDIFF(Month, 0, DATEADD(M, 0, @RunDate)) + 1, 0) + 6 - (DATEPART(Weekday,
							DATEADD(Month,
							DATEDIFF(Month,0, DATEADD(M, 0, @RunDate)) + 1, 0))
						+ @@DateFirst + 2) % 7 ,103)
				)

	INSERT INTO @NewData(FlowId,LaunchDate,LaunchRef)
	SELECT 
		WF.FlowId,
		@dt	AS LaunchDate,
		'Risk_Appetite_DT:'+ CONVERT(VARCHAR(10), @dt, 112) AS LaunchRef
	FROM [Scheduler].[Workflows] WF 
	WHERE WF.FlowName='Risk Appetite Review'
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
	WHEN NOT MATCHED THEN 
	INSERT (FlowId, LaunchDate, LaunchRef, IsActive)
	VALUES (Src.FlowId, Src.LaunchDate, Src.LaunchRef, Src.IsActive);

	MERGE INTO [Scheduler].[WorkflowParameters] WFP
	USING ( 
			SELECT LaunchList.[WorkflowLaunchId]
				, 'Risk_Appetite_DT' as KeyName
				,  REPLACE(LaunchList.LaunchRef,'Risk_Appetite_DT:','') AS Value
				, 'ContentString' as ContentType
			FROM [Scheduler].[WorkflowLaunchList] LaunchList
			INNER JOIN @NewData NEW
			ON NEW.LaunchRef = LaunchList.LaunchRef
		) Src
	ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
	AND wfp.[Value] = Src.[Value]
	WHEN NOT MATCHED THEN 
	INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
	VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] );			
END	
			
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
