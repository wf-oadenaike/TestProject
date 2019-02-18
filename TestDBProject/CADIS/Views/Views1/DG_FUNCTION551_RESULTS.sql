CREATE VIEW "CADIS"."DG_FUNCTION551_RESULTS" AS 
SELECT ET."RiskAppetiteEventId",ET."RiskAppetiteRegisterId",ET."RiskEventTypeID",ET."SubmittedByPersonId",ET."RiskEventDate",ET."RiskEventDetails",ET."JiraIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Risk"."RiskAppetiteEvents" ET WITH (NOLOCK)
