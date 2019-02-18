CREATE PROC CADIS.SPREBUILDINDEXES 
	@TableName sysname='%' 
AS
/************************************************
	REBUILD TABLE INDEXES
************************************************/
SET NOCOUNT ON
DECLARE @qt char(1)
DECLARE @execstr varchar(8000)
DECLARE @table sysname
SET @qt = CHAR(34)
DECLARE Tables CURSOR FOR
	SELECT	@qt + TABLE_SCHEMA + @qt + '.' + @qt + TABLE_NAME + @qt 
	FROM	INFORMATION_SCHEMA.TABLES 
	WHERE	TABLE_TYPE = 'BASE TABLE'
	AND	TABLE_NAME LIKE @TableName
OPEN Tables
FETCH Tables INTO @table
WHILE (@@FETCH_STATUS=0) BEGIN
	PRINT CHAR(13) + 'Rebuilding indexes for: ' + @table
	SET @execstr = 'DBCC DBREINDEX(''' + @table + ''')'
	EXEC(@execstr)
	FETCH Tables INTO @table
END
CLOSE Tables
DEALLOCATE Tables
RETURN 0
