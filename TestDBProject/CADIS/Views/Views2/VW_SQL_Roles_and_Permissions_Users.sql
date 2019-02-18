CREATE VIEW "CADIS"."VW_SQL_Roles_and_Permissions_Users"
AS
SELECT NAME 
FROM sys.database_principals 
WHERE NAME NOT LIKE 'CADIS%'
AND NAME NOT LIKE 'db_%'
