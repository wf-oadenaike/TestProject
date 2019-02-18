﻿CREATE VIEW "CADIS"."DG_FUNCTION268_RESULTS" AS 
SELECT ET."RiskReturnId",ET."RiskOwnerRoleId",ET."JiraKey",ET."CreatedForPersonId",ET."DueDate",ET."CompletionDate",ET."CompletedByPersonId",ET."IsActive",ET."RiskRAG",ET."RiskRAGRationale",ET."ManagementActivities",ET."JoinGUID",ET."RiskReturnCreationDatetime",ET."RiskReturnLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Risk"."RiskReturn" ET WITH (NOLOCK)