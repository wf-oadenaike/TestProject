CREATE PROC CADIS.SPREBUILDINDEX 
	@TableName sysname
AS
/************************************************
	REBUILD TABLE INDEXES
************************************************/
SET NOCOUNT ON
DECLARE @execstr varchar(8000)
PRINT CHAR(13) + 'Rebuilding indexes for: ' + @TableName
SET @execstr = 'DBCC DBREINDEX(''' + @TableName + ''')'
EXEC(@execstr)
RETURN 0
