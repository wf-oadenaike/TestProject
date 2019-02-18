



CREATE PROCEDURE [CADIS].[usp_DBREINDEX]
	-- Add the parameters for the stored procedure here

AS
BEGIN

DECLARE @TableName varchar(255) 
 
DECLARE TableCursor CURSOR FOR
SELECT table_schema + '.' + table_name FROM information_schema.tables 
WHERE table_type = 'base table' 
--and table_schema = 'dbo'
 
OPEN TableCursor 
 
FETCH NEXT FROM TableCursor INTO @TableName 
WHILE @@FETCH_STATUS = 0 
BEGIN
DBCC DBREINDEX(@TableName,'',90) 
FETCH NEXT FROM TableCursor INTO @TableName 
END
 
CLOSE TableCursor 
 
DEALLOCATE TableCursor

END



