CREATE PROCEDURE [CADIS_SYS].[SPDC_DROPOBSOLETEOBJECTS]
(
	@REPORT_ONLY CHAR(1) = 'Y', @LOG_RUNID INT = NULL, @FORCE_DROP BIT = 0, @PRINT_TO_DATATABLE CHAR(1) = 'N'
)
AS
BEGIN
/* ============================================================= */
/* DataConstructor - Procedure to drop obsolete database objects */
/* ============================================================= */
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
WHERE [NAME] = 'DataConstructor'
*/
PRINT ('--=================================================--')
PRINT ('--     DataConstructor - Drop Obsolete Objects     --')
PRINT ('--  ---------------------------------------------  --')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('===============')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('DataConstructor')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('===============')
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
		EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, 'DataConstructor - Drop Obsolete Objects'
END
PRINT ('--=================================================--')
--
-- PROCEDURES
--
PRINT ('-----------------------')
PRINT ('--  DC - Procedures  --')
PRINT ('-----------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Procedures')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('----------')
END
/* clear up ALL VALIDATE procs, regardless of OBSOLETE status of owner */
DECLARE drop_proc_cursor1 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND LEFT(obj.name,20) = 'spDCPROCESSVALIDATE_')
OPEN drop_proc_cursor1;
FETCH NEXT FROM drop_proc_cursor1 INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes.
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Procs 1'; 
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
/* clear up DC procs where owner OBSOLETE */
DECLARE drop_proc_cursor2 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND (LEFT(obj.name,12) = 'spDCPROCESS_'
	     OR LEFT(obj.name,18) = 'spDCPROCESSREPORT_'
	     OR LEFT(obj.name,23) = 'spDCPROCESSVALUESOURCE_'))
	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	    ON ((obj.name = 'spDCPROCESS_' + dc.CODE)
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_AUDIT')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_RESETCOLWATCH')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_RECALCULATECOLWATCH')
	    OR  (obj.name LIKE 'spDCPROCESS[_]%[_]FOOTER[_]BLOCK')
	    OR  (obj.name LIKE 'spDCPROCESS[_]%[_]INSERT[_]PROCESS[_]KEYS')
	    OR  (obj.name LIKE 'spDCPROCESS[_]%[_]MODIFIED[_]RECORDS')
	    OR  (obj.name LIKE 'spDCPROCESS[_]%[_]DELETE[_]ALL[_]ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_NEW_ROWS_INTO_PRELIM_OP')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_DEBUG_RULES')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_TRUNCATE_CONTROL_BUFFER')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_RUN_INFO_USER_DETAILS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_PRELIM_TO_TARGET_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_TRUNCATE_LAST_CONSTRUCTED_TABLES') 
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_CLEAR_TARGET_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_EXISTING_ROWS_INTO_PRELIM_OP')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_UPDATE_TARGET_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_UNMARK_CHANGES')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_TRUNCATE_PRELIM_TABLE')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_TRUNCATE_OUTPUT_KEYS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_UPDATE_INFO_VALUE_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_UPDATE_INFO_RUNID_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_UPDATE_INFO_RULE_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_INSERT_INFO_VALUE_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_INSERT_INFO_RUNID_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_INSERT_INFO_RULE_ROWS')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_BUILD_OUTPUT_KEYS_TABLE')
	    OR  (obj.name = 'spDCPROCESS_' + dc.CODE + '_DEFAULT_FIELD_RULES')
	    OR  (obj.name = 'spDCPROCESSREPORT_' + dc.CODE)
	    OR  (obj.name = 'spDCPROCESSVALUESOURCE_' + dc.CODE)
	    OR  (LEFT(obj.name,LEN('spDCPROCESS_' + dc.CODE + '_GROUP')) = 'spDCPROCESS_' + dc.CODE + '_GROUP')
	    OR  (LEFT(obj.name,LEN('spDCPROCESS_' + dc.CODE + '_EXTRA_VALID_RULES_GROUP')) = 'spDCPROCESS_' + dc.CODE + '_EXTRA_VALID_RULES_GROUP'))
    WHERE (dc.OBSOLETE > 0
    AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0))
OPEN drop_proc_cursor2;
FETCH NEXT FROM drop_proc_cursor2 INTO @schema, @object
WHILE (@@FETCH_STATUS <> -1)
BEGIN
	/* 
	   The CO_PROCESSDBOBJECT table is always current, and only contains objects (input or output) for LIVE processes,
	   therefore if the object exists in this table it is still used, even if the process that originally created it is obsolete. 
	   NB! don't refer to CO_PROCESSDBOBJECT table for GROUP procs as they should NEVER exist in the CO_PROCESSDBOBJECT table 
	   as we can't determine what they will be until Verify/Create.
	*/
	IF (@FORCE_DROP = 1 OR NOT EXISTS (SELECT [ID] FROM [CADIS_SYS].[CO_PROCESSDBOBJECT] WHERE [TYPE] = @type_proc AND LOWER([SCHEMA]) = LOWER(@schema) AND LOWER([NAME]) = LOWER(@object))
	OR  @object LIKE 'spDCPROCESS[_]%[_]GROUP[0-9]%') 
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Procs 2'; 
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
PRINT ('--  DC - Tables  --')
PRINT ('-------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('------')
END
-- Process Level 1
DECLARE drop_tbl_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND (obj.name LIKE 'DC[_]%[_]AUDIT'
	   OR obj.name LIKE 'DC[_]%[_]PREP[_]OP' 
	   OR obj.name LIKE 'DC[_]%[_]CBUF'
	   OR obj.name LIKE 'DC[_]%[_]INFO[_]RULE' 
	   OR obj.name LIKE 'DC[_]%[_]INFO[_]UPDATED'			/* no longer used, but kept for completeness in case of upgraded DB*/
	   OR obj.name LIKE 'DC[_]%[_]PRELIM[_]INFO[_]RULE'		/* no longer used, but kept for completeness in case of upgraded DB*/
	   OR obj.name LIKE 'DC[_]%[_]PRELIM[_]INFO[_]UPD'))	/* no longer used, but kept for completeness in case of upgraded DB*/
 	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	    ON ('_' + dc.CODE + '_' = SUBSTRING(obj.name,3,LEN(dc.CODE)+2)
	    AND SUBSTRING(obj.name,LEN(dc.CODE)+4,LEN(obj.name)-LEN(dc.CODE)-3) 
		IN ('_AUDIT',
		    '_PREP_OP',
		    '_CBUF',
		    '_INFO_RULE',
		    '_INFO_UPDATED',
		    '_PRELIM_INFO_RULE',
		    '_PRELIM_INFO_UPD'))
    WHERE dc.OBSOLETE > 0
    AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0)
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Tables P1'; 
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
-- Process Level 2
DECLARE drop_tbl_cursor1 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND (obj.name LIKE 'DC[_]%[_]PRELIM[_]OP'	/* no longer used, but kept for completeness in case of upgraded DB*/
	   OR obj.name LIKE 'DC[_]%[_]PRELIM[_]AUDIT'))	/* no longer used, but kept for completeness in case of upgraded DB*/
 	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	    ON ('_' + dc.CODE +'_' = SUBSTRING(obj.name,3,LEN(dc.CODE)+2)
	    AND SUBSTRING(obj.name,LEN(dc.CODE)+4,LEN(obj.name)-LEN(dc.CODE)-3) 
		IN ('_PRELIM_OP',
		    '_PRELIM_AUDIT'))
    WHERE dc.OBSOLETE > 0
    AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0)
OPEN drop_tbl_cursor1;
FETCH NEXT FROM drop_tbl_cursor1 INTO @schema, @object
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Tables P2'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_tbl_cursor1 INTO @schema, @object;
END;
CLOSE drop_tbl_cursor1;
DEALLOCATE drop_tbl_cursor1;
-- Input Level
DECLARE drop_tbl_cursor2 CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON obj.schema_id = usr.schema_id
	   AND (
			(  usr.name IN ('CADIS')
		       AND (obj.name LIKE 'DC[_]%[_]%[_]CBUF'
		         OR obj.name LIKE 'DC[_]%[_]%[_]PRLIM')  /* no longer used, but kept for completeness in case of upgraded DB*/
			)
		 OR (  usr.name IN ('CADIS_PROC')
	           AND obj.name LIKE 'DC[_]%[_]%[_]PREP'
			)
		)
 	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	    ON ('_' + dc.CODE + '_' = SUBSTRING(obj.name,3,LEN(dc.CODE)+2))
    WHERE dc.OBSOLETE > 0
    AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0)
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Tables 2'; 
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
	   AND obj.name LIKE 'DC[_]%[_]ARCHIVE[_][0-9]%')
 	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	    ON ('_' + dc.CODE + '_' = SUBSTRING(obj.name,3,LEN(dc.CODE)+2)
	    AND SUBSTRING(obj.name,LEN(dc.CODE)+4,9) = '_ARCHIVE_') 
    WHERE dc.OBSOLETE > 0
    AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0)
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Tables 3'; 
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
PRINT ('--  DC - Input Process Tables  --')
PRINT ('---------------------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Input Process Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('--------------------')
END
DECLARE drop_iptbl_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name 
    FROM CADIS_SYS.CO_COMPONENT co
	INNER JOIN CADIS_SYS.CO_PROCESSINPUT ip
	  ON (co.NAME = 'DataConstructor' AND co.ID = ip.COMPONENTID)
	INNER JOIN sys.tables obj 
	   ON (obj.name = 'DC_INPUT' + CONVERT(VARCHAR(20),ip.INPUTID) + '_PROCESSKEYS'
	   OR obj.name = 'DC_INPUT' + CONVERT(VARCHAR(20),ip.INPUTID) + '_COLWATCH')
	INNER JOIN sys.schemas usr
	   ON (usr.name = 'CADIS_PROC' AND usr.schema_id = obj.schema_id)
	/* MUST do inner join, as there is a defect in the .Net code 
	   which doesn't update the PROCESSINPUT table 
           when the process or input SHORTNAME changes */
 	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	  ON dc.CODE = ip.PROCESSNAME
    WHERE ip.OBSOLETE > 0 -- i.e. has been explicitly deleted 
       OR (
	   dc.OBSOLETE > 0 -- process is obsolete
           /* even though CODE is not used in INPUT PROCESS object names, we cannot delete if CODE is re-used 
              as CODE is the only means of joining to the CO_PROCESSINPUT table */
           AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0) -- and CODE not reused
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Input Process Tables'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
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
PRINT ('--  DC - Views  --')
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
	   AND usr.name IN ('CADIS')
	   AND (obj.name LIKE 'DC[_]%[_]RSLT'
	   OR obj.name LIKE 'DC[_]%[_]AUDIT'))
 	INNER JOIN CADIS_SYS.DC_CONSTRUCTION dc
	    ON ('_' + dc.CODE + '_' = SUBSTRING(obj.name,3,LEN(dc.CODE)+2)
	    AND SUBSTRING(obj.name,LEN(dc.CODE)+4,LEN(obj.name)-LEN(dc.CODE)-3) 
		IN ('_RSLT',
		    '_AUDIT'))
    WHERE dc.OBSOLETE > 0
    AND dc.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DC_CONSTRUCTION WHERE OBSOLETE = 0)
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
			SELECT @return=@@error,@errmsg='DC: Clear Obsolete Views'; 
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
