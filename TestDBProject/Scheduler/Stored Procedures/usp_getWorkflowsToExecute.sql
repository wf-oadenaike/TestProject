CREATE PROCEDURE [Scheduler].[usp_getWorkflowsToExecute] AS
-------------------------------------------------------------------------------------- 
-- Name: [Scheduler].[usp_getWorkflowsToExecute]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- D.Bacchus: 12/02/2018 JIRA: DAP-1773 amended to not try and run failed ManyWho workflows the next day.
--
-- 
-------------------------------------------------------------------------------------- 

    WITH CTE_Log AS
    (
        SELECT	DISTINCT 
				WorkflowLaunchId
				,StateId
        FROM	[Scheduler].[WorkflowRunStateLog] wrsl
        WHERE	WorkflowRunStateLogId = (SELECT MAX(WorkflowRunStateLogId) FROM [Scheduler].[WorkflowRunStateLog] tmp WHERE tmp.WorkflowLaunchId = wrsl.WorkflowLaunchId)
    )
    
    SELECT	DISTINCT
			wll.[WorkflowLaunchId]
			,wll.[FlowId]
			,w.[FlowName] 
			,w.[TenantId]
			,w.[Player]
    FROM	[Scheduler].[WorkflowLaunchList] wll
	INNER	JOIN [Scheduler].[Workflows] w ON wll.FlowId = w.FlowId
	LEFT	JOIN CTE_Log cte ON cte.WorkflowLaunchId = wll.WorkflowLaunchId
    WHERE	wll.LaunchDate <= CONVERT(DATE, GETDATE()) 
	AND		IsActive = 1
	AND		cte.WorkflowLaunchId IS NULL -- has not already run

RETURN 0

