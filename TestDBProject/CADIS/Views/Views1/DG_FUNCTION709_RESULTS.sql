CREATE VIEW "CADIS"."DG_FUNCTION709_RESULTS" AS 
SELECT ET."EventId",ET."HuddleEventId",ET."EventTypeId",ET."EventType",ET."SubmittedByPersonId",ET."SubmittedByName",ET."EventDate",ET."EventDetails",ET."JiraIssueKey",ET."JoinGUID" FROM "Access.ManyWho"."HuddleRegisterEventsReadOnlyVw" ET WITH (NOLOCK)
