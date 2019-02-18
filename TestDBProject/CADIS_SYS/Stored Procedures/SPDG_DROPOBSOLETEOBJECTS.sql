CREATE PROCEDURE [CADIS_SYS].[SPDG_DROPOBSOLETEOBJECTS]
(
	@REPORT_ONLY CHAR(1) = 'Y', @LOG_RUNID INT = NULL, @PRINT_TO_DATATABLE CHAR(1) = 'N'
)
AS
BEGIN
/* =========================================================== */
/* DataGenerator - Procedure to drop obsolete database objects */
/* =========================================================== */
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
WHERE [NAME] = 'DataGenerator'
*/
PRINT ('--=================================================--')
PRINT ('--      DataGenerator - Drop Obsolete Objects      --')
PRINT ('--  ---------------------------------------------  --')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('=============')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('DataGenerator')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('=============')
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
		EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, 'DataGenerator - Drop Obsolete Objects'
END
PRINT ('--=================================================--')
--
-- TABLES
--
PRINT ('-------------------')
PRINT ('--  DG - Tables  --')
PRINT ('-------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('------')
END
DECLARE drop_tbl_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_SYS','CADIS_PROC')
	   AND (obj.name LIKE 'DG[_]FUNCTION[_]AUDIT%'
	     OR obj.name LIKE 'DG[_]FUNCTION[_]ARCHIVE%[_][0-9]%'))
 	INNER JOIN CADIS_SYS.DG_FUNCTION dg
	    ON (obj.name = 'DG_FUNCTION_AUDIT' + CONVERT(VARCHAR(10),dg.IDENTIFIER) 
	    OR obj.name LIKE 'DG[_]FUNCTION[_]ARCHIVE' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '[_][0-9]%')
    WHERE dg.OBSOLETE > 0
OPEN drop_tbl_cursor;
FETCH NEXT FROM drop_tbl_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_table AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
	BEGIN
		SELECT @SQL = 'DROP TABLE [' + @schema + + '].[' + @object + '];'
		PRINT @SQL;
		SET @UnusedObjectsFound = 1
		IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
			INSERT INTO @PrintLog ([REPORT]) VALUES ('[' + @schema + + '].[' + @object + ']');
		IF @Drop = 1
		BEGIN
			EXEC (@SQL);
			/*****Check for errors*****/ 
			SELECT @return=@@error,@errmsg='DG: Clear Obsolete Tables'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_tbl_cursor INTO @schema, @object;
END;
CLOSE drop_tbl_cursor;
DEALLOCATE drop_tbl_cursor;
--
-- VIEWS
--
PRINT ('------------------')
PRINT ('--  DG - Views  --')
PRINT ('------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Views')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('-----')
END
DECLARE drop_vw_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.views obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS','CADIS_PROC')
	   AND (obj.name LIKE 'DG[_]FUNCTION[0-9]%[_]RESULTS' OR obj.name LIKE 'DG[_]%[_]AUDIT' ))
 	INNER JOIN CADIS_SYS.DG_FUNCTION dg
	    ON (obj.name = 'DG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_RESULTS'
		or obj.name = 'DG_' + REPLACE(dg.name, ' ', '_') + '_AUDIT')
    WHERE dg.OBSOLETE > 0
OPEN drop_vw_cursor;
FETCH NEXT FROM drop_vw_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_view AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
	BEGIN
		SELECT @SQL = 'DROP VIEW [' + @schema + + '].[' + @object + '];'
		PRINT @SQL;
		SET @UnusedObjectsFound = 1
		IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
			INSERT INTO @PrintLog ([REPORT]) VALUES ('[' + @schema + + '].[' + @object + ']');
		IF @Drop = 1
		BEGIN
			EXEC (@SQL);
			/*****Check for errors*****/ 
			SELECT @return=@@error,@errmsg='DG: Clear Obsolete Views'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_vw_cursor INTO @schema, @object;
END;
CLOSE drop_vw_cursor;
DEALLOCATE drop_vw_cursor;
--
-- PROCEDURES
--
PRINT ('-----------------------')
PRINT ('--  DG - Procedures  --')
PRINT ('-----------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Procedures')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('----------')
END
/* clear up DG procs where owner OBSOLETE */
DECLARE drop_proc_cursor CURSOR
FOR
    /* functions */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (
		   obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND LEN(obj.name) > 13
	   AND LEFT(obj.name,13) = 'SPDG_FUNCTION'
	   AND ISNUMERIC(SUBSTRING(obj.name,14,1)) = 1
			)
	INNER JOIN CADIS_SYS.DG_FUNCTION dg
	    ON (
				obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_ARCHIVE'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_AUDITINS'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_AUDITSEL'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXDEL'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXINS'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXSEL'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXUPD'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXSELSINGLEROW'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXSELROWNUMBER'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_INBOXGROUPSEL'
			OR	obj.name = 'SPDG_FUNCTION' + CONVERT(VARCHAR(10),dg.IDENTIFIER) + '_AUDITLATESTCHANGE'
			)
    WHERE dg.OBSOLETE > 0
OPEN drop_proc_cursor;
FETCH NEXT FROM drop_proc_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_proc AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
	BEGIN
		SELECT @SQL = 'DROP PROC [' + @schema + + '].[' + @object + '];'
		PRINT @SQL;
		SET @UnusedObjectsFound = 1
		IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
			INSERT INTO @PrintLog ([REPORT]) VALUES ('[' + @schema + + '].[' + @object + ']');
		IF @Drop = 1
		BEGIN
			EXEC (@SQL);
			/*****Check for errors*****/ 
			SELECT @return=@@error,@errmsg='DM: Clear Obsolete Procs'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_proc_cursor INTO @schema, @object;
END;
CLOSE drop_proc_cursor;
DEALLOCATE drop_proc_cursor;
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
