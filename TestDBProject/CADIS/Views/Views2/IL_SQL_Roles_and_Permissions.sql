CREATE VIEW "CADIS"."IL_SQL_Roles_and_Permissions" AS 
SELECT V."MemberName" AS "Username",V."RoleName" AS "Role" FROM "CADIS"."VW_SQL_Roles_and_Permissions" V
