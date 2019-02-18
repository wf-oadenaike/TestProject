
CREATE PROC [dbo].[ufn_SLA_by_Entity] (@TABLE_NAME VARCHAR(255),@DATE_FIELD NVARCHAR(MAX), @WHERE NVARCHAR(MAX))
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[ufn_SLA_by_Entity]
-- 
-- Params:    @PLATFORM	

-- 
-------------------------------------------------------------------------------------- 
AS

BEGIN

DECLARE @SQL					NVARCHAR(MAX)
DECLARE @RECORD_COUNT			int
DECLARE @PREVIOUS_RECORD_COUNT	int

-- debug
--SET @TABLE_NAME = 'dbo.T_MASTER_POS'
--SET @SQL = 'SELECT COUNT(*) FROM ' + @TABLE_NAME
--SET @WHERE = ' WHERE POSITION_DATE = ''2016-03-07 00:00:00.000'''

SET @SQL = 'SELECT COUNT(1) FROM '+ @TABLE_NAME + ' WHERE '+ @DATE_FIELD + ' = ''2016-03-07 00:00:00.000'''

--PRINT @SQL
EXEC sp_executesql @SQL

RETURN
END
