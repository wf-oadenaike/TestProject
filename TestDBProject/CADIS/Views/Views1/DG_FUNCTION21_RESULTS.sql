CREATE VIEW "CADIS"."DG_FUNCTION21_RESULTS" AS 
SELECT ET."WorkflowLaunchId",ET."FlowId",ET."LaunchDate",ET."LaunchRef",ET."IsActive",ET."JoinGUID",ET."CreatedDate" FROM "Scheduler"."WorkflowLaunchList" ET WITH (NOLOCK)
