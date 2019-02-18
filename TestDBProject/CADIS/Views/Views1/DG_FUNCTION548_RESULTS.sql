CREATE VIEW "CADIS"."DG_FUNCTION548_RESULTS" AS 
SELECT ET."BaseOrderID",ET."EventDate",ET."OrderID",ET."PostedBy",ET."Narrative",ET."EventType" FROM "dbo"."RecentDeaggregatedSlackNarrativeVw" ET WITH (NOLOCK)
