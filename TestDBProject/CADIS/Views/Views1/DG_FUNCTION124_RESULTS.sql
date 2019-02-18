﻿CREATE VIEW "CADIS"."DG_FUNCTION124_RESULTS" AS 
SELECT ET."ClientTakeOnTaskId",ET."Stage",ET."SummaryDetails",ET."ReporterRole",ET."AssigneeRole",ET."Description",ET."DueDate",ET."IsActive",ET."JiraEpicKey",ET."Labels",ET."StoryPoints",ET."IssueType",ET."ReporterJiraUsername",ET."AssigneeJiraUsername",ET."ClientTakeOnTasksCreationDatetime",ET."ClientTakeOnTasksLastModifiedDatetime" FROM "Access.ManyWho"."ClientTakeOnTasksReadOnlyVw" ET WITH (NOLOCK)
