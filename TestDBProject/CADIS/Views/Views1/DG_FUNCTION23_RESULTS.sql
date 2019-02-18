CREATE VIEW "CADIS"."DG_FUNCTION23_RESULTS" AS 
SELECT ET."ConflictId",ET."ConflictsRegisterGenericId",ET."ConflictIdentifier",ET."ConflictIdentifierOverride",ET."ConflictsRegisterCategoryId1",ET."ConflictsRegisterCategoryId2",ET."DocumentationFolderUrl",ET."CreatedByPersionId",ET."CreationDate" FROM "Compliance"."ConflictsRegisterIdentification" ET WITH (NOLOCK)
