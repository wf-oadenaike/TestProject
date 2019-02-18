﻿CREATE VIEW "CADIS"."IL_Scheduler_Workflow_Run_State_Log" AS 
SELECT V."WorkflowRunStateLogId" AS "Workflow Run State Log ID",V."WorkflowLaunchId" AS "Workflow Launch ID", J2.DF AS "State ID",V."Note" AS "Note",V."CreatedDate" AS "Created Date" FROM "Scheduler"."WorkflowRunStateLog" V LEFT OUTER JOIN (SELECT DISTINCT "StateId" AS JF,"State" AS DF FROM "Scheduler"."WorkflowRunStateTypes")  J2 ON  J2.JF=V."StateId"
