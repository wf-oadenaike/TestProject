CREATE VIEW "CADIS"."DG_FUNCTION12_RESULTS" AS 
SELECT ET."EBIEventTypeBK",ET."EBIEventTypeId",ET."EBIEventDescription" FROM "Compliance"."EBIRegisterEventTypes" ET WITH (NOLOCK)
