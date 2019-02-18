﻿CREATE VIEW "CADIS"."IL_Compliance_EBI_Register_Events" AS 
SELECT V."EBIRegisterEventId" AS "EBI Register Event ID",V."EBIRegisterId" AS "EBI RegisterId", J2.DF AS "EBI Event Type Id",V."EventDetails" AS "Details",V."EventDate" AS "Event Date",V."EventTrueFalse" AS "Event True False", J6.DF AS "Recorded By Person ID",V."DocumentationFolderLink" AS "Documentation Folder Link",V."WorkflowVersionGUID" AS "Workflow Version GUID",V."JoinGUID" AS "Join GUID",V."EBIEventCreationDatetime" AS "EBI Event Creation Datetime",V."EBIEventLastModifiedDatetime" AS "EBI Event Last Modified Datetime" FROM "Compliance"."EBIRegisterEvents" V LEFT OUTER JOIN (SELECT DISTINCT "EBIEventTypeId" AS JF,"EBIEventDescription" AS DF FROM "Compliance"."EBIRegisterEventTypes")  J2 ON  J2.JF=V."EBIEventTypeId" LEFT OUTER JOIN (SELECT DISTINCT "PersonId" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J6 ON  J6.JF=V."RecordedByPersonId"