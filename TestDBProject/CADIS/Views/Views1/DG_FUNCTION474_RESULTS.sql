CREATE VIEW "CADIS"."DG_FUNCTION474_RESULTS" AS 
SELECT ET."WorkflowLaunchId",ET."CreatedDate",ET."LaunchDate",ET."StateCreatedDate",ET."StateId",ET."FlowName",ET."LaunchRef" FROM "CADIS"."VW_ManyWho_Workflow_Scheduler_Log" ET WITH (NOLOCK)
