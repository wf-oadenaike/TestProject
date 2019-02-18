CREATE PROCEDURE [CADIS_SYS].[SPDI_DROPOBSOLETEOBJECTS]
(
	@REPORT_ONLY CHAR(1) = 'Y', @LOG_RUNID INT = NULL, @FORCE_DROP BIT = 0, @PRINT_TO_DATATABLE CHAR(1) = 'N'
)
AS
BEGIN
/* =========================================================== */
/* DataInspector - Procedure to drop obsolete database objects */
/* =========================================================== */
/* If @REPORT_ONLY = Y will just create drop statement to output window. */
/* If @REPORT_ONLY <> Y will perform the drop. */
/* @FORCE_DROP will force dropping of obsolete objects even when being used 
   by downstream components (according to CO_PROCESSDBOBJECT) */
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
WHERE [NAME] = 'DataInspector'
*/
PRINT ('--=================================================--')
PRINT ('--      DataInspector - Drop Obsolete Objects      --')
PRINT ('--  ---------------------------------------------  --')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('=============')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('DataInspector')
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
		EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, 'DataInspector - Drop Obsolete Objects'
END
PRINT ('--=================================================--')
--
-- PROCEDURES
--
PRINT ('-----------------------')
PRINT ('--  DI - Procedures  --')
PRINT ('-----------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Procedures')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('----------')
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
END
/* clear up ALL VALIDATE procs, regardless of OBSOLETE status of owner */
DECLARE drop_proc_cursor1 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND LEFT(obj.name,20) = 'spDIPROCESSVALIDATE_')
OPEN drop_proc_cursor1;
FETCH NEXT FROM drop_proc_cursor1 INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	   NB! DON'T refer to CO_PROCESSDBOBJECT here, as VALIDATE procs are not permanent and do not belong in this table.
	*/
	--IF NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_proc AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
	--BEGIN
		SELECT @SQL = 'DROP PROC [' + @schema + + '].[' + @object + '];'
		PRINT @SQL;
		SET @UnusedObjectsFound = 1
		IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
			INSERT INTO @PrintLog ([REPORT]) VALUES ('[' + @schema + + '].[' + @object + ']');
		IF @Drop = 1
		BEGIN
			EXEC (@SQL);
			/*****Check for errors*****/ 
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Procs 1'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	--END;
	FETCH NEXT FROM drop_proc_cursor1 INTO @schema, @object;
END;
CLOSE drop_proc_cursor1;
DEALLOCATE drop_proc_cursor1;
/* clear up DI procs where owner OBSOLETE */
DECLARE drop_proc_cursor2 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND (LEFT(obj.name,12) = 'spDIPROCESS_'
	    OR  LEFT(obj.name,18) = 'SPDISUMMARYREPORT_'
	    OR  LEFT(obj.name,23) = 'SPDIINPUTSUMMARYREPORT_'))
	INNER JOIN CADIS_SYS.DI_INSPECTION di
	    ON ((obj.name = 'spDIPROCESS_' + di.CODE)  
	    OR  (obj.name = 'SPDISUMMARYREPORT_' + di.CODE) 
	    OR  (obj.name = 'SPDIINPUTSUMMARYREPORT_' + di.CODE)) 
    WHERE di.OBSOLETE > 0
    AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0)
OPEN drop_proc_cursor2;
FETCH NEXT FROM drop_proc_cursor2 INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_proc AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Procs 2'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_proc_cursor2 INTO @schema, @object;
END;
CLOSE drop_proc_cursor2;
DEALLOCATE drop_proc_cursor2;
--
-- TABLES
--
PRINT ('-------------------')
PRINT ('--  DI - Tables  --')
PRINT ('-------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('------')
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
END
-- Process level 1
DECLARE drop_tbl_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND (obj.name LIKE 'DI[_]%[_]CBUF'
	   OR obj.name LIKE 'DI[_]%[_]PRELIM[_]RESULTS'
	   OR obj.name LIKE 'DI[_]%[_]RESULTS'))
 	INNER JOIN CADIS_SYS.DI_INSPECTION di
	    ON ('_' + di.CODE +'_' = SUBSTRING(obj.name,3,LEN(di.CODE)+2)
	    AND SUBSTRING(obj.name,LEN(di.CODE)+4,LEN(obj.name)-LEN(di.CODE)-3) 
		IN ('_CBUF',
		    '_RESULTS',
		    '_PRELIM_RESULTS'))
    WHERE di.OBSOLETE > 0
    AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0)
OPEN drop_tbl_cursor;
FETCH NEXT FROM drop_tbl_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_table AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Tables P1'; 
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
-- Input Level
DECLARE drop_tbl_cursor2 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND obj.name LIKE 'DI[_]%[_]%[_]CBUF')
 	INNER JOIN CADIS_SYS.DI_INSPECTION di
	    ON ('_' + di.CODE + '_' = SUBSTRING(obj.name,3,LEN(di.CODE)+2))
    WHERE di.OBSOLETE > 0
    AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0)
OPEN drop_tbl_cursor2;
FETCH NEXT FROM drop_tbl_cursor2 INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_table AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Tables 2'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_tbl_cursor2 INTO @schema, @object;
END;
CLOSE drop_tbl_cursor2;
DEALLOCATE drop_tbl_cursor2;
-- Archive
DECLARE drop_tbl_cursor3 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND obj.name LIKE 'DI[_]%[_]ARCHIVE[_][0-9]%')
 	INNER JOIN CADIS_SYS.DI_INSPECTION di
	    ON ('_' + di.CODE +'_' = SUBSTRING(obj.name,3,LEN(di.CODE)+2)
	    AND SUBSTRING(obj.name,LEN(di.CODE)+4,9) = '_ARCHIVE_') 
    WHERE di.OBSOLETE > 0
    AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0)
OPEN drop_tbl_cursor3;
FETCH NEXT FROM drop_tbl_cursor3 INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_table AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Tables 3'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_tbl_cursor3 INTO @schema, @object;
END;
CLOSE drop_tbl_cursor3;
DEALLOCATE drop_tbl_cursor3;
--
-- INPUT PROCESS TABLES
--
PRINT ('---------------------------------')
PRINT ('--  DI - Input Process Tables  --')
PRINT ('---------------------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Input Process Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('--------------------')
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
END
DECLARE drop_iptbl_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM CADIS_SYS.CO_COMPONENT co
	INNER JOIN CADIS_SYS.CO_PROCESSINPUT ip
	  ON (co.NAME = 'DataInspector' AND co.ID = ip.COMPONENTID)
	INNER JOIN sys.tables obj 
	   ON (obj.name = 'DI_INPUT' + CONVERT(VARCHAR(20),ip.INPUTID) + '_PROCESSKEYS'
	   OR obj.name = 'DI_INPUT' + CONVERT(VARCHAR(20),ip.INPUTID) + '_COLWATCH')
	INNER JOIN sys.schemas usr
	   ON (usr.name IN ('CADIS_SYS','CADIS_PROC') AND usr.schema_id = obj.schema_id)
 	/* MUST do inner join, as there is a defect in the .Net code 
	   which doesn't update the PROCESSINPUT table 
           when the process or input SHORTNAME changes */
 	INNER JOIN CADIS_SYS.DI_INSPECTION di
	  ON di.CODE = ip.PROCESSNAME
    WHERE ip.OBSOLETE > 0 -- i.e. has been explicitly deleted 
       OR (
	   di.OBSOLETE > 0 -- process is obsolete
           /* even though CODE is not used in INPUT PROCESS object names, we CANNOT delete if CODE is re-used 
              as CODE is the only means of joining to the CO_PROCESSINPUT table */
           AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0) -- and CODE not reused
           )
OPEN drop_iptbl_cursor;
FETCH NEXT FROM drop_iptbl_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_table AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Input Process Tables'; 
			IF (@return<>0) GOTO TheEnd;
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_iptbl_cursor INTO @schema, @object;
END;
CLOSE drop_iptbl_cursor;
DEALLOCATE drop_iptbl_cursor;
--
-- VIEWS
--
PRINT ('------------------')
PRINT ('--  DI - Views  --')
PRINT ('------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Views')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('-----')
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
END
DECLARE drop_vw_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.views obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND (obj.name LIKE 'DI[_]%[_]RSLT'
	   OR obj.name LIKE 'DI[_]%[_]%[_]RSLT'))
 	INNER JOIN CADIS_SYS.DI_INSPECTION di
	    ON '_' + di.CODE + '_' = SUBSTRING(obj.name,3,LEN(di.CODE)+2)
    WHERE di.OBSOLETE > 0
    AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0)
OPEN drop_vw_cursor;
FETCH NEXT FROM drop_vw_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_view AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Views'; 
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
PRINT ('------------------------')
PRINT ('--  DI - Input Views  --')
PRINT ('------------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Input Views')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('-----------')
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
END
DECLARE drop_ivw_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM CADIS_SYS.CO_COMPONENT co
	INNER JOIN CADIS_SYS.CO_PROCESSINPUT ip
	  ON (co.NAME = 'DataInspector' AND co.ID = ip.COMPONENTID)
 	INNER JOIN CADIS_SYS.DI_INSPECTION di
	  ON di.CODE = ip.PROCESSNAME
	INNER JOIN sys.views obj 
	   ON obj.name = 'DI_' + CONVERT(VARCHAR(20),di.CODE) + '_' + CONVERT(VARCHAR(20),ip.INPUTNAME) + '_RSLT'
	INNER JOIN sys.schemas usr
	   ON (usr.name IN ('CADIS') AND usr.schema_id = obj.schema_id)
 	/* MUST do inner join, as there is a defect in the .Net code 
	   which doesn't update the PROCESSINPUT table 
           when the process or input SHORTNAME changes */
    WHERE ip.OBSOLETE > 0 -- i.e. has been explicitly deleted 
       OR (
	   di.OBSOLETE > 0 -- process is obsolete
           /* even though CODE is not used in INPUT PROCESS object names, we CANNOT delete if CODE is re-used 
              as CODE is the only means of joining to the CO_PROCESSINPUT table */
           AND di.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DI_INSPECTION WHERE OBSOLETE = 0) -- and CODE not reused
           )
OPEN drop_ivw_cursor;
FETCH NEXT FROM drop_ivw_cursor INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	*/
	IF @FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_view AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
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
			SELECT @return=@@error,@errmsg='DI: Clear Obsolete Input Views'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_ivw_cursor INTO @schema, @object;
END;
CLOSE drop_ivw_cursor;
DEALLOCATE drop_ivw_cursor;
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
