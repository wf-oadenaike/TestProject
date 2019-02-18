CREATE VIEW "CADIS"."DG_FUNCTION62_RESULTS" AS 
SELECT ET."RoleName",ET."RoleId",ET."ActiveFlag",ET."RoleCreationDate",ET."RoleLastModifiedDate",ET."ControlId",ET."RoleBK",ET."SourceSystemId",ET."SourceSystemName" FROM "Access.ManyWho"."RolesVw" ET WITH (NOLOCK)
