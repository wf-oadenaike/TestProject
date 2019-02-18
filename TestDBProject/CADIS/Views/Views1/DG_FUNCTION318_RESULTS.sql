CREATE VIEW "CADIS"."DG_FUNCTION318_RESULTS" AS 
SELECT ET."StopListId",ET."StoppedCompanyName",ET."EventDate",ET."Ticker",ET."BloombergId",ET."StopListEventTypeId",ET."StopListEventType",ET."EventDetails" FROM "Access.ManyWho"."StopListEventReasonsReadOnlyVw" ET WITH (NOLOCK)
