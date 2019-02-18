CREATE VIEW "CADIS"."IL_Scheduler_Workflow_Parameters" AS 
SELECT V."Id" AS "ID",V."WorkflowLaunchId" AS "Workflow Launch ID",V."Key" AS "Key",V."Value" AS "Value",V."ContentType" AS "Content Type",V."JoinGUID" AS "Join GUID" FROM "Scheduler"."WorkflowParameters" V
