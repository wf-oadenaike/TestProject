CREATE VIEW "CADIS"."VW_SQL_Roles_and_Permissions"
AS
SELECT mp.name AS MemberName, rp.name AS RoleName, 'EXEC sp_addrolemember N''' + rp.name + ''', N''' + mp.name + '''' AS AssignSQL,
 'EXEC sp_droprolemember N''' + rp.name + ''', N''' + mp.name + '''' AS RemoveSQL
FROM sys.database_role_members a
INNER JOIN sys.database_principals rp ON rp.principal_id = a.role_principal_id
INNER JOIN sys.database_principals AS mp ON mp.principal_id = a.member_principal_id
