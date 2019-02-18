﻿CREATE VIEW "CADIS"."IL_Organisation_Meeting_Agenda_Items" AS 
SELECT V."MeetingAgendaItemId" AS "Meeting Agenda Item ID",V."MeetingRegisterId" AS "Meeting Register ID",V."AgendaItemNameBK" AS "Agenda Item Name BK",V."AgendaItemDetails" AS "Agenda Item Details", J4.DF AS "Reporter Role ID", J5.DF AS "Assignee Role ID",V."IssueType" AS "Issue Type",V."ActiveFlag" AS "Active Flag",V."LagLead" AS "Lag Lead",V."DocumentationFolderLink" AS "Documentation Folder Link",V."MeetingAgendaItemCreationDatetime" AS "Meeting Agenda Item Creation Date",V."MeetingAgendaItemLastModifiedDatetime" AS "Meeting Agenda Item Last Modified Date",V."Frequency",V."Purpose",V."Outcome" FROM "Organisation"."MeetingAgendaItems" V LEFT OUTER JOIN (SELECT DISTINCT "RoleId" AS JF,"RoleName" AS DF FROM "Core"."Roles")  J4 ON  J4.JF=V."ReporterRoleId" LEFT OUTER JOIN (SELECT DISTINCT "RoleId" AS JF,"RoleName" AS DF FROM "Core"."Roles")  J5 ON  J5.JF=V."AssigneeRoleId"
