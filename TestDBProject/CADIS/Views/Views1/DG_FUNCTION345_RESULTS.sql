CREATE VIEW "CADIS"."DG_FUNCTION345_RESULTS" AS 
SELECT ET."SignatoryOwnerId",ET."ProcDocumentId",ET."PolicyId",ET."RoleId",ET."OwnerRole",ET."PersonId",ET."OwnerPerson",ET."IsOwner",ET."IsSignatory",ET."IsActive",ET."JoinGUID",ET."SignatoryOwnerCreationDatetime",ET."SignatoryOwnerLastModifiedDatetime" FROM "Access.WebDev"."SignatoryOwnerReadOnlyVw" ET WITH (NOLOCK)
