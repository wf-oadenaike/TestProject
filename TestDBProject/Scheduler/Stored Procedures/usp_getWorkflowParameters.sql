CREATE PROCEDURE [Scheduler].[usp_getWorkflowParameters]
	@WorkflowLaunchId INT
AS
	SELECT
		w.[Key] 
		,w.[Value]
		,w.[ContentType]
	FROM [Scheduler].[WorkflowParameters] w
	WHERE w.WorkflowLaunchId = @WorkflowLaunchId
RETURN 0
