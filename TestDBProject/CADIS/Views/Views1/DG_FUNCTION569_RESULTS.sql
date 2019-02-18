CREATE VIEW "CADIS"."DG_FUNCTION569_RESULTS" AS 
SELECT ET."NarrativeEventid",ET."BaseOrderID",ET."OrderID",ET."EventDate",ET."PostedBy",ET."Narrative",ET."EventType" FROM "dbo"."ufn_SlackCommentaryForOrderTree"(NULL) ET
