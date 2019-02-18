﻿CREATE VIEW "CADIS"."DG_FUNCTION553_RESULTS" AS 
SELECT ET."RiskAppetiteKRIEventId",ET."RiskAppetiteKRIRegisterId",ET."RiskKRIEventTypeID",ET."SubmittedByPersonId",ET."RiskKRIEventDate",ET."RiskKRIEventDetails",ET."JiraIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Risk"."RiskAppetiteKRIEvents" ET WITH (NOLOCK)
