CREATE VIEW "CADIS"."DG_FUNCTION550_RESULTS" AS 
SELECT ET."RiskAppetiteEventId",ET."RiskAppetiteRegisterId",ET."RiskEventTypeID",ET."RiskEventType",ET."SubmittedByPersonId",ET."SubmittedByName",ET."RiskEventDate",ET."RiskEventDetails",ET."JiraIssueKey",ET."JoinGUID" FROM "Access.ManyWho"."RiskAppetiteEventsReadOnlyVw" ET WITH (NOLOCK)
