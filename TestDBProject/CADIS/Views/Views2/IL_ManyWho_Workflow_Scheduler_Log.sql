CREATE VIEW "CADIS"."IL_ManyWho_Workflow_Scheduler_Log" AS 
SELECT V."WorkflowLaunchId",V."CreatedDate",V."LaunchDate",V."StateCreatedDate",V."StateId",V."FlowName",V."LaunchRef" FROM "CADIS"."VW_ManyWho_Workflow_Scheduler_Log" V
