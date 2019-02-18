CREATE VIEW "CADIS"."DG_FUNCTION552_RESULTS" AS 
SELECT ET."RiskAppetiteKRIEventId",ET."RiskAppetiteKRIRegisterId",ET."RiskKRIEventTypeID",ET."RiskEventType",ET."SubmittedByPersonId",ET."SubmittedByName",ET."RiskKRIEventDate",ET."RiskKRIEventDetails",ET."JiraIssueKey",ET."JoinGUID" FROM "Access.ManyWho"."RiskAppetiteKRIEventsReadOnlyVw" ET WITH (NOLOCK)
