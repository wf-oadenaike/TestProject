
CREATE PROC usp_MultObjDrop 
@Name VARCHAR(MAX)
AS

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
DROP VIEW ' 
    + QUOTENAME(s.name)
    + '.' + QUOTENAME(t.name) + ';'
   FROM sys.views AS t
    INNER JOIN sys.schemas AS s
    ON t.[schema_id] = s.[schema_id] 
	and t.name LIKE @Name

PRINT @sql;

