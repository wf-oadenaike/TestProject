CREATE VIEW "CADIS"."DG_FUNCTION25_RESULTS" AS 
SELECT ET."ConflictsRegisterMitigationID",ET."ConflictId",ET."MitigationDetails",ET."CreatedByPersionId",ET."CreationDate" FROM "Compliance"."ConflictsRegisterMitigation" ET WITH (NOLOCK)
