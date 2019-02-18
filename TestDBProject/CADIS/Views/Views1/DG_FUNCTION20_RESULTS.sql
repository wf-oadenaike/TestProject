CREATE VIEW "CADIS"."DG_FUNCTION20_RESULTS" AS 
SELECT ET."WorkflowRunStateLogId",ET."WorkflowLaunchId",ET."StateId",ET."Note",ET."CreatedDate" FROM "Scheduler"."WorkflowRunStateLog" ET WITH (NOLOCK)
