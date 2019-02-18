CREATE VIEW "CADIS"."DG_FUNCTION404_RESULTS" AS 
SELECT ET."ConflictsRegisterGenericId",ET."GenericConflictTitle",ET."GenericConflictDetails",ET."CreatedByPersonId",ET."CreationDate" FROM "Compliance"."ConflictsRegisterGenerics" ET WITH (NOLOCK)
