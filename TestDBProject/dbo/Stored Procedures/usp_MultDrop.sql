CREATE PROC usp_MultDrop 
@ID int
AS

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
DROP VIEW ' 
    + QUOTENAME(s.name)
    + '.' + QUOTENAME(t.name) + ';'
   FROM sys.views AS t
    INNER JOIN sys.schemas AS s
    ON t.[schema_id] = s.[schema_id] 
	and s.schema_id = @ID

PRINT @sql;

