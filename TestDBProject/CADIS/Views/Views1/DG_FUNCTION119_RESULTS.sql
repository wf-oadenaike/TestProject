﻿CREATE VIEW "CADIS"."DG_FUNCTION119_RESULTS" AS 
SELECT ET."ClientTakeOnTaskId",ET."Stage",ET."SummaryDetails",ET."ReporterRole",ET."AssigneeRole",ET."Description",ET."DueDate",ET."IsActive",ET."JiraEpicKey",ET."Labels",ET."StoryPoints",ET."IssueType",ET."ClientTakeOnTasksCreationDatetime",ET."ClientTakeOnTasksLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Sales"."ClientTakeOnTasks" ET WITH (NOLOCK)
