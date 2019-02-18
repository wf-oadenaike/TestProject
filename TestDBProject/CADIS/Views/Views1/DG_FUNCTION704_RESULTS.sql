CREATE VIEW "CADIS"."DG_FUNCTION704_RESULTS" AS 
SELECT ET."CircleId",ET."RoleId",ET."CircleName",ET."CircleLabel",ET."ParentCircleId",ET."RoleName",ET."CoreRoleFlag",ET."RoleStatus" FROM "Access.ManyWho"."VwNewOrgStructureCircleRolesOverview" ET WITH (NOLOCK)
