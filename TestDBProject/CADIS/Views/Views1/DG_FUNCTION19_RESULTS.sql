CREATE VIEW "CADIS"."DG_FUNCTION19_RESULTS" AS 
SELECT ET."Id",ET."WorkflowLaunchId",ET."Key",ET."Value",ET."ContentType",ET."JoinGUID" FROM "Scheduler"."WorkflowParameters" ET WITH (NOLOCK)
