CREATE PROCEDURE [CADIS_SYS].[SPRB_DROPOBSOLETEOBJECTS]
(
	@REPORT_ONLY CHAR(1) = 'Y', @LOG_RUNID INT = NULL, @PRINT_TO_DATATABLE CHAR(1) = 'N'
)
AS
BEGIN
/* ========================================================= */
/* RuleBuilder - Procedure to drop obsolete database objects */
/* ========================================================= */
/* If @REPORT_ONLY = Y will just create drop statement to output window. */
/* If @REPORT_ONLY <> Y will perform the drop. */
DECLARE @SQL VARCHAR(2000)
DECLARE @Drop BIT
DECLARE @return INT, @proc SYSNAME, @errmsg VARCHAR(1024)
DECLARE @schema VARCHAR(200), @object VARCHAR(200)
DECLARE @type_table TINYINT, @type_view TINYINT, @type_proc TINYINT, @type_func TINYINT
DECLARE @PrintLog TABLE ( [REPORT] [nvarchar](MAX) NOT NULL )
DECLARE @UnusedObjectsFound BIT
SET @UnusedObjectsFound = 0
SET @return = 0
SELECT @type_table = 1, @type_view = 2, @type_proc = 4, @type_func = 8
/*
DECLARE @compid INT
SELECT @compid = ID
FROM CADIS_SYS.CO_COMPONENT
WHERE [NAME] = 'RuleBuilder'
*/
PRINT ('--=================================================--')
PRINT ('--       RuleBuilder - Drop Obsolete Objects       --')
PRINT ('--  ---------------------------------------------  --')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('===========')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('RuleBuilder')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('===========')
END
IF UPPER(@REPORT_ONLY) = 'Y'
BEGIN
	SET @Drop = 0
	PRINT ('--  REPORT_ONLY = Y (Objects will NOT be dropped)  --')
END
ELSE
BEGIN
	SET @Drop = 1
	PRINT ('--  REPORT_ONLY = N (objects WILL be dropped)      --')
	IF @LOG_RUNID IS NOT NULL
		EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, 'RuleBuilder - Drop Obsolete Objects'
END
PRINT ('--=================================================--')
--
-- FUNCTIONS
--
PRINT ('----------------------')
PRINT ('--  RB - Functions  --')
PRINT ('----------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
INSERT INTO @PrintLog ([REPORT]) VALUES ('Functions')
INSERT INTO @PrintLog ([REPORT]) VALUES ('---------')
END
DECLARE drop_func_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
   	INNER JOIN sys.all_objects obj 
	   ON (obj.schema_id = usr.schema_id
	   AND obj.type = 'FN' 
	   AND usr.name IN ('CADIS_PROC')
	   AND LEN(obj.name) > 11
	   AND LEFT(obj.name,11) = 'RB_FUNCTION'
	   AND ISNUMERIC(SUBSTRING(obj.name,12,1)) = 1)
	INNER JOIN CADIS_SYS.RB_FUNCTION rb
	    ON obj.name = 'RB_FUNCTION' + CONVERT(VARCHAR(10),rb.IDENTIFIER)
    WHERE rb.OBSOLETE > 0
OPEN drop_func_cursor;
FETCH NEXT FROM drop_func_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_func AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
	BEGIN
		SELECT @SQL = 'DROP FUNCTION [' + @schema + + '].[' + @object + '];'
		PRINT @SQL;
		SET @UnusedObjectsFound = 1
		IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
			INSERT INTO @PrintLog ([REPORT]) VALUES ('[' + @schema + + '].[' + @object + ']');
		IF @Drop = 1
		BEGIN
			EXEC (@SQL);
			/*****Check for errors*****/ 
			SELECT @return=@@error,@errmsg='RB: Clear Obsolete Functions'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_func_cursor INTO @schema, @object;
END;
CLOSE drop_func_cursor;
DEALLOCATE drop_func_cursor;
IF ((UPPER(@PRINT_TO_DATATABLE) = 'Y') AND (@UnusedObjectsFound = 1))
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('[Unused objects found]')
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
END
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
	SELECT [REPORT] FROM @PrintLog;
TheEnd:
IF (@return <> 0)
BEGIN
	SELECT	@proc = name FROM sysobjects WHERE id = @@PROCID
	SET	@errmsg = 'Error occured in procedure ' + @proc + ',error = ' + STR(@return) + ':(' + ISNULL(@errmsg,'') + ')'
	RAISERROR (@errmsg, 16, 1)
END
RETURN (@return)
END;
