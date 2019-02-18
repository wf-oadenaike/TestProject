CREATE VIEW "CADIS"."DG_FUNCTION589_RESULTS" AS 
SELECT ET."EventId",ET."ToolId",ET."EventDetails",ET."SubmittedByPersonId",ET."SubmittedByPersonName",ET."EventDate",ET."EventType",ET."JoinGUID" FROM "Access.ManyWho"."CriticalUserDefinedToolsEventsReadOnlyVw" ET WITH (NOLOCK)
