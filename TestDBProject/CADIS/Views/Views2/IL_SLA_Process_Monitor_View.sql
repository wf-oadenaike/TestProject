﻿CREATE VIEW "CADIS"."IL_SLA_Process_Monitor_View" AS 
SELECT V."PLATFORM" AS "Platform",V."SOURCE" AS "Source",V."ENTITY" AS "Entity",V."SUB_ENTITY" AS "Sub Entity",V."DESCRIPTION" AS "Description",V."DIRECTION" AS "Direction",V."RUN_DATE" AS "Run Date",V."ROW_COUNT" AS "Row Count",V."PREVIOUS_ROW_COUNT" AS "Previuos Row Count",V."RUN_STATUS" AS "Run Status",V."TIME_STATUS" AS "Time Status",V."RECORDS" AS "Records",V."TOLERANCE_PRECENT" AS "Tolerance",V."SOLUTION" AS "Solution",V."TABLE_NAME" AS "Table Name",V."EXPECTED_TIME_GMT" AS "Expected Time GMT",V."EXPECTED_TIME_TOLERANCE_MINUTES" AS "Expected Time GMT Tolerance", J18.DF AS "Owner",V."EMAIL_RECIPIENT" AS "Email Recipient",V."ALERT_SENT" AS "Alert Sent",V."IS_ACTIVE" AS "Active" FROM "dbo"."V_SLA_PROCESS_MONITOR" V LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."PersonsActiveVw")  J18 ON  J18.JF=V."OWNER"
