CREATE VIEW "CADIS"."DG_FUNCTION706_RESULTS" AS 
SELECT ET."RoleId",ET."PersonId",ET."RoleName",ET."Purpose",ET."CircleId",ET."CircleName",ET."CoreRoleFlag",ET."FocusArea",ET."RoleStatus",ET."PersonsName" FROM "Access.ManyWho"."VwNewOrgStructureRolePersonDetails" ET WITH (NOLOCK)
