CREATE VIEW "CADIS"."DG_FUNCTION707_RESULTS" AS 
SELECT ET."RoleId",ET."RoleName",ET."Purpose",ET."CircleId",ET."CircleName",ET."CoreRoleFlag",ET."FocusArea",ET."Accountability",ET."RoleStatus" FROM "Access.ManyWho"."VwNewOrgStructureRoleDetails" ET WITH (NOLOCK)
