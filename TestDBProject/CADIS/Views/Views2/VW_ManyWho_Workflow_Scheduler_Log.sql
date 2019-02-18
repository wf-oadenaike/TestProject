CREATE VIEW "CADIS"."VW_ManyWho_Workflow_Scheduler_Log"
AS
SELECT

	wfll.WorkflowLaunchId

    	,wfll.CreatedDate

    	,wfll.LaunchDate

	,max(CAST(wfsl.CreatedDate AS DATE)) AS StateCreatedDate

	,max(wfsl.StateId) AS StateId

	,wf.FlowName

	,wfll.LaunchRef
FROM[Scheduler].[WorkflowLaunchList] wfll
    
LEFT JOIN [Scheduler].[Workflows] wf 
	ON wfll.FlowId = wf.FlowId

LEFT OUTER JOIN [Scheduler].[WorkflowRunStateLog] wfsl 
	ON wfll.WorkflowLaunchId = wfsl.WorkflowLaunchId

WHERE IsActive = 1

	AND (LaunchDate = CAST(GETDATE() AS DATE)

	OR (wfsl.[CreatedDate] = CAST(GETDATE() AS DATE)))

GROUP BY
    
	wfll.[WorkflowLaunchId]
	,wfll.FlowId

	,wf.FlowName

	,wfll.LaunchDate

	,wfll.LaunchRef
    
	,wfll.IsActive

	,wfll.CreatedDate

