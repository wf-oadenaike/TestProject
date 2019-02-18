CREATE VIEW "CADIS"."DG_FUNCTION125_RESULTS" AS 
SELECT ET."StopListEventId",ET."StopListReasonId",ET."EventDetails",ET."EventDate",ET."StopListStatusName",ET."SubmittedByPersonId",ET."SubmittedBy",ET."JIRAIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."StopListEventsReadOnlyVw" ET WITH (NOLOCK)
