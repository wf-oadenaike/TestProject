﻿CREATE VIEW "CADIS"."IL_SLA_Param" AS 
SELECT V."PLATFORM" AS "Platform",V."SOURCE" AS "Source",V."ENTITY" AS "Entity",V."SUB_ENTITY" AS "Sub Entity",V."DESCRIPTION" AS "Description",V."DIRECTION" AS "Direction",V."RECORDS" AS "Records",V."TOLERANCE_PRECENT" AS "Tolerance",V."SOLUTION" AS "Solution",V."TABLE_NAME" AS "Table Name",V."EXPECTED_TIME_GMT" AS "Expected Time GMT",V."EXPECTED_TIME_TOLERANCE_MINUTES" AS "Expected Time GMT Tolerance",V."EMAIL_RECIPIENT" AS "Email Recipient", J13.DF AS "Owner",V."SEND_SLACK" AS "Send Slack",V."SEND_EMAIL" AS "Send Email",V."IS_ACTIVE" AS "Active",V."CADIS_SYSTEM_INSERTED" AS "Inserted",V."CADIS_SYSTEM_UPDATED" AS "Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "Changed By" FROM "dbo"."T_SLA_PARAM" V LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."PersonsActiveVw")  J13 ON  J13.JF=V."OWNER"