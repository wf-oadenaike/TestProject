CREATE VIEW "CADIS"."DG_FUNCTION7_RESULTS" AS 
SELECT ET."UserInteractionTypeId",ET."UserInteractionType",ET."CreationDate" FROM "Compliance"."EBIRegisterUserInteractionTypes" ET WITH (NOLOCK)
