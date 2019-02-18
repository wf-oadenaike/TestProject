﻿CREATE VIEW "CADIS"."IL_Investment_FinProms_Register" AS 
SELECT V."FinPromRegisterId" AS "FinProm Registered ID",V."CommsNameBK" AS "Comms Name BK",V."FinPromType" AS "FinProm Type",V."PromotionChannel" AS "Promotion Channel",V."ThirdPartyYesNo" AS "Third Party Yes or No",V."IssueDueDate" AS "Issue Due Date",V."JIRAProjectInitiationDate" AS "JIRA Project Initiation Date",V."RecurrenceFrequency" AS "Recurrence Frequency",V."ApprovalDate" AS "Approval Date",V."ComplianceComments" AS "Compliance Comments", J10.DF AS "Compliance Person ID", J11.DF AS "Compiance Role ID",V."FinPromStatus" AS "FinProm Status",V."JIRAEpicKey" AS "JIRA Epic Key",V."DocumentationFolderLink" AS "Documentation Folder Link",V."Notes" AS "Notes",V."IsFinProm" AS "Is FinProm",V."IntendedAudienceDetails" AS "Intended Audience Details",V."ExpiryDate" AS "Expiry Date",V."ReviewFrequency" AS "Review Frequency",V."IssuedBy",V."IssuedDate",V."Author",V."MandateId",V."SubmittedByPersonId",V."JiraIssueKey",V."ComplianceJiraKey",V."Topic",V."Purpose",V."FinPromCreationDatetime" AS "FinProm Creation Datetime",V."FinPromLastModifiedDatetime" AS "FinProm Event Last Modified Date",V."Outcome",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Investment"."FinPromsRegister" V LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J10 ON  J10.JF=V."CompliancePersonId" LEFT OUTER JOIN (SELECT DISTINCT "RoleId" AS JF,"RoleName" AS DF FROM "Core"."Roles")  J11 ON  J11.JF=V."ComplianceRoleId"
