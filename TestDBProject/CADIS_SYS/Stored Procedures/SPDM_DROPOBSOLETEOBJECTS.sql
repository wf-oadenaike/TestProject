CREATE PROCEDURE [CADIS_SYS].[SPDM_DROPOBSOLETEOBJECTS]
(
	@REPORT_ONLY CHAR(1) = 'Y', @LOG_RUNID INT = NULL, @FORCE_DROP BIT = 0, @PRINT_TO_DATATABLE CHAR(1) = 'N'
)
AS
BEGIN
/* ========================================================= */
/* DataMatcher - Procedure to drop obsolete database objects */
/* ========================================================= */
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
WHERE [NAME] = 'DataMatcherProcess'
*/
PRINT ('--=================================================--')
PRINT ('--       DataMatcher - Drop Obsolete Objects       --')
PRINT ('--  ---------------------------------------------  --')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('===========')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('DataMatcher')
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
		EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, 'DataMatcher - Drop Obsolete Objects'
END
PRINT ('--=================================================--')
--
-- PROCEDURES
--
PRINT ('-----------------------')
PRINT ('--  DM - Procedures  --')
PRINT ('-----------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Procedures')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('----------')
END
/* clear up DM procs where owner OBSOLETE */
DECLARE drop_proc_cursor CURSOR
FOR
    /* clear up ALL mp VALIDATE procs, regardless of OBSOLETE status of owner */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_SYS','CADIS_PROC')
	   AND LEFT(obj.name,15) = 'SPDM_MATCHPOINT'
	   AND ISNUMERIC(SUBSTRING(obj.name,16,1)) = 1
	   AND RIGHT(obj.name,9) = '_VALIDATE') 
    -----
    UNION
    -----
    /* clear up ALL source VALIDATE procs, regardless of OBSOLETE status of owner */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_SYS','CADIS_PROC')
	   AND obj.name LIKE 'SPDM_MP[0-9]%[_]SOURCE[0-9]%[_]VALIDATE')
    -----
    UNION
    -----
    /* clear up ALL rule VALIDATE procs, regardless of OBSOLETE status of owner */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_SYS','CADIS_PROC')
	   AND obj.name LIKE 'SPDM_MP[0-9]%[_]SOURCE[0-9]%[_]RULE[0-9]%[_]VALIDATE')
    -----
    UNION
    -----
    /* matchpoints */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (
		   obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND LEN(obj.name) > 15
	   AND (
			(	LEFT(obj.name,15) = 'SPDM_MATCHPOINT'
			AND ISNUMERIC(SUBSTRING(obj.name,16,1)) = 1
			AND ISNUMERIC(RIGHT(obj.name,1)) = 1
			)
			OR
			(	(obj.name LIKE 'SPDM_MP[0-9]%[_]INBOX[_]%'
			  OR obj.name LIKE 'SPDM_MP[0-9]%[_]RESULT[_]%')
			AND obj.name NOT LIKE 'SPDM_MP[0-9]%[_]SOURCE[0-9]%'
			)
		)
		)
	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (
				obj.name = 'SPDM_MATCHPOINT' + CONVERT(VARCHAR(10),dm.IDENTIFIER)
			OR	obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_INBOX_PROPOSEDSEL'
			OR	obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_INBOX_RESULTSEL'
			OR	obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_INBOX_RESULTSUMMARY'
			OR	obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_RESULT_UPDATE'
			OR	obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_RESULT_CADISIDEXISTS'
			)
    WHERE dm.OBSOLETE > 0
    -----
    UNION
    -----
    /* sources */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND obj.name LIKE 'SPDM_MP[0-9]%[_]SOURCE[0-9]%'
	   AND obj.name NOT LIKE 'SPDM[_]MP[0-9]%[_]SOURCE[0-9]%[_]RULE[0-9]%'
	   AND obj.name NOT LIKE 'SPDM[_]MP[0-9]%[_]SOURCE[0-9]%[_]VALIDATE')
	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name LIKE 'SPDM[_]MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '[_]SOURCE[0-9]%')
	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON (
			dms.MATCHPOINTID = dm.IDENTIFIER
	    AND (
			 obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID)
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_AUDIT_RESULTSEL'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_CLEAROBSOLETE'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_INBOX_CADISIDEXISTS'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_INBOX_INFOSEL'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_INBOX_RESULTSEL'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_INBOX_SOURCESEL'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_INBOX_SOURCESELWITHRULETERMS'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_REALIGN_MATCH'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_REALIGN_REALIGNEXISTINGNEW'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_REALIGN_REALIGNNULL'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_REALIGN_REALIGNPROVISIONAL'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_REALIGN_SOURCE'
		  OR obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_RESULT_UPDATEFROMINBOX'
			)
			)
    WHERE dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0
    -----
    UNION
    -----
    /* rules */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.procedures obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND obj.name LIKE 'SPDM[_]MP[0-9]%[_]SOURCE[0-9]%[_]RULE[0-9]%')
	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name LIKE 'SPDM[_]MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '[_]SOURCE[0-9]%[_]RULE[0-9]%')
	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON (dms.MATCHPOINTID = dm.IDENTIFIER
	    AND obj.name LIKE 'SPDM[_]MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '[_]SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '[_]RULE[0-9]%')
	INNER JOIN CADIS_SYS.DM_RULE dmr
	    ON (obj.name = 'SPDM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID) + '_RULE' + CONVERT(VARCHAR(10),dmr.RULEID))
    WHERE (dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0
       OR dmr.DELETED IS NOT NULL) -- rule is deleted
OPEN drop_proc_cursor;
FETCH NEXT FROM drop_proc_cursor INTO @schema, @object
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
--
-- TABLES
--
PRINT ('-------------------')
PRINT ('--  DM - Tables  --')
PRINT ('-------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('------')
END
DECLARE drop_tbl_cursor CURSOR
FOR
    /* matchpoints */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND (obj.name LIKE 'DM[_]MATCHPOINT[0-9]%'
	   OR obj.name LIKE 'DM[_]MP[0-9]%[_]RESULT'
	   OR obj.name LIKE 'DM[_]MP[0-9]%[_]RESULT[_]AUDIT'
	   OR obj.name LIKE 'DM[_]MP[0-9]%[_]PROPOSED'))
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name = 'DM_MATCHPOINT' + CONVERT(VARCHAR(10),dm.IDENTIFIER)
  	    OR obj.name = 'DM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_PROPOSED'
	    OR obj.name = 'DM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_RESULT'
	    OR obj.name = 'DM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_RESULT_AUDIT'
	    OR obj.name LIKE 'DM[_]MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '[_]RESULT[_]ARCHIVE[_][0-9]%')
    WHERE dm.OBSOLETE > 0
      AND obj.name <> 'DM_MATCHPOINT' 
    -----
    UNION
    -----
    /* sources - system */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND obj.name LIKE 'DM[_]MP[0-9]%[_]SOURCE[0-9]%')
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON obj.name LIKE 'DM[_]MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '[_]SOURCE[0-9]%'
	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON dms.MATCHPOINTID = dm.IDENTIFIER
	    AND (obj.name = 'DM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID)
	     OR  obj.name = 'DM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_SOURCE' + CONVERT(VARCHAR(10),dms.SOURCEID)+ '_REVISION')
    WHERE dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0
    -----
    UNION
    -----
    /* sources - cbuff and idg*/
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND (obj.name LIKE 'DM[_]%[_]%[_]CBUFF' OR obj.name LIKE 'DM[_]%[_]%[_]IDG'))
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON obj.name LIKE 'DM[_]' + REPLACE(dm.CODE,'_','[_]') + '[_]%[_]CBUFF' OR obj.name LIKE 'DM[_]' + REPLACE(dm.CODE,'_','[_]') + '[_]%[_]IDG'
	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON dms.MATCHPOINTID = dm.IDENTIFIER
	    AND (obj.name LIKE 'DM[_]' + REPLACE(dm.CODE,'_','[_]') + '[_]' + REPLACE(dms.SHORTNAME,'_','[_]') + '[_]CBUFF' OR
		obj.name LIKE 'DM[_]' + REPLACE(dm.CODE,'_','[_]') + '[_]' + REPLACE(dms.SHORTNAME,'_','[_]') + '[_]IDG')
    WHERE (dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0)
      /* SHORTNAME used in CBUFF table name, so must exclude if SHORTNAME still in use elsewhere */
      AND dm.CODE + '_' + dms.SHORTNAME NOT IN 
              (SELECT dm1.CODE + '_' + dms1.SHORTNAME 
                 FROM CADIS_SYS.DM_MATCHPOINT dm1
               INNER JOIN CADIS_SYS.DM_SOURCE dms1
 	          ON dms1.MATCHPOINTID = dm1.IDENTIFIER
               WHERE dm1.OBSOLETE = 0 AND dms1.OBSOLETE = 0)
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
			SELECT @return=@@error,@errmsg='DM: Clear Obsolete Tables'; 
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
-- INPUT PROCESS TABLES
--
PRINT ('---------------------------------')
PRINT ('--  DM - Input Process Tables  --')
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
	  ON (co.NAME = 'DataMatcherProcess' AND co.ID = ip.COMPONENTID)
   	INNER JOIN sys.tables obj 
	   ON (obj.name = 'DM_INPUT' + CONVERT(VARCHAR(20),ip.INPUTID) + '_PROCESSKEYS'
	   OR obj.name = 'DM_INPUT' + CONVERT(VARCHAR(20),ip.INPUTID) + '_COLWATCH')
	INNER JOIN sys.schemas usr
	  ON (usr.name IN ('CADIS_SYS','CADIS_PROC') AND usr.schema_id = obj.schema_id)
 	INNER JOIN CADIS_SYS.DM_SOURCE dms
	  ON dms.SOURCEID = ip.INPUTID
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	  ON dm.IDENTIFIER = dms.MATCHPOINTID 
    WHERE ip.OBSOLETE > 0 -- i.e. input has been explicitly deleted 
       OR dms.OBSOLETE > 0 -- i.e. input source has been explicitly deleted 
       OR dm.OBSOLETE > 0 -- i.e. process is obsolete
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
			SELECT @return=@@error,@errmsg='DM: Clear Obsolete Input Process Tables'; 
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
PRINT ('---------------------------------')
PRINT ('--  DM - Archive Tables        --')
PRINT ('---------------------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Archive Tables')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('--------------')
END
DECLARE drop_archtbl_cursor CURSOR
FOR
    SELECT DISTINCT usr.name, obj.name
    FROM sys.schemas usr
	INNER JOIN sys.tables obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS_PROC')
	   AND obj.name LIKE 'DM[_]MP[0-9]%[_]RESULT[_]ARCHIVE[_][0-9]%')
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON ('DM_MP' + CONVERT(VARCHAR(10), dm.IDENTIFIER) +'_' = SUBSTRING(obj.name,1,LEN(CONVERT(VARCHAR(10), dm.IDENTIFIER))+6))
    WHERE dm.OBSOLETE > 0
OPEN drop_archtbl_cursor;
FETCH NEXT FROM drop_archtbl_cursor INTO @schema, @object
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
			SELECT @return=@@error,@errmsg='DM: Clear Obsolete Archive Tables'; 
			IF (@return<>0) GOTO TheEnd;
			PRINT('-- dropped --');
			IF @LOG_RUNID IS NOT NULL
				EXEC CADIS_SYS.SPLOGINFO @LOG_RUNID, @SQL
		END;
	END;
	FETCH NEXT FROM drop_archtbl_cursor INTO @schema, @object;
END;
CLOSE drop_archtbl_cursor;
DEALLOCATE drop_archtbl_cursor;
--
-- VIEWS
--
PRINT ('------------------')
PRINT ('--  DM - Views  --')
PRINT ('------------------')
IF UPPER(@PRINT_TO_DATATABLE) = 'Y'
BEGIN
	INSERT INTO @PrintLog ([REPORT]) VALUES (' ')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('Views')
	INSERT INTO @PrintLog ([REPORT]) VALUES ('-----')
END
DECLARE drop_vw_cursor CURSOR
FOR
    /* matchpoints */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.views obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND ( obj.name LIKE 'DM[_]%[_]KEYS'
		OR   obj.name LIKE 'DM[_]%[_]INBOX'
		OR   obj.name LIKE 'DM[_]%[_]SEARCH'))
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name = 'DM_' + dm.CODE + '_KEYS' 
		OR  obj.name = 'DM_' + dm.CODE + '_INBOX' 
		OR  obj.name = 'DM_' + dm.CODE + '_SEARCH') 
    WHERE dm.OBSOLETE > 0
    AND dm.CODE NOT IN (SELECT CODE FROM CADIS_SYS.DM_MATCHPOINT WHERE OBSOLETE = 0)
    -----
    UNION
    -----
    /* sources */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.views obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND obj.name LIKE 'DM[_]%[_]%[_]OUT')
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name LIKE 'DM[_]' + REPLACE(dm.CODE,'_','[_]') + '[_]%[_]OUT') 
 	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON dms.MATCHPOINTID = dm.IDENTIFIER
	    AND obj.name = 'DM_' + dm.CODE + '_' + dms.SHORTNAME + '_OUT'
    WHERE (dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0)
      AND dm.CODE + '_' + dms.SHORTNAME NOT IN 
              (SELECT dm1.CODE + '_' + dms1.SHORTNAME 
                 FROM CADIS_SYS.DM_MATCHPOINT dm1
               INNER JOIN CADIS_SYS.DM_SOURCE dms1
 	          ON dms1.MATCHPOINTID = dm1.IDENTIFIER
               WHERE dm1.OBSOLETE = 0 AND dms1.OBSOLETE = 0)
    -----
    UNION
    -----
    /* sources INFO */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.views obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND obj.name LIKE 'DM[_]%[_]%[_]INFO')
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name LIKE 'DM[_]' + REPLACE(dm.CODE,'_','[_]') + '[_]%[_]INFO') 
 	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON dms.MATCHPOINTID = dm.IDENTIFIER
	    AND obj.name = 'DM_' + dm.CODE + '_' + dms.SHORTNAME + '_INFO'
    WHERE (dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0)
      AND dm.CODE + '_' + dms.SHORTNAME NOT IN 
              (SELECT dm1.CODE + '_' + dms1.SHORTNAME 
                 FROM CADIS_SYS.DM_MATCHPOINT dm1
               INNER JOIN CADIS_SYS.DM_SOURCE dms1
 	          ON dms1.MATCHPOINTID = dm1.IDENTIFIER
               WHERE dm1.OBSOLETE = 0 AND dms1.OBSOLETE = 0)
    -----
    UNION
    -----
    /* sources INBOX */
    SELECT DISTINCT usr.name, obj.name 
    FROM sys.schemas usr
	INNER JOIN sys.views obj 
	   ON (obj.schema_id = usr.schema_id
	   AND usr.name IN ('CADIS')
	   AND obj.name LIKE 'DM[_]MP[0-9]%[_]%[_]INBOX')
 	INNER JOIN CADIS_SYS.DM_MATCHPOINT dm
	    ON (obj.name LIKE 'DM[_]MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '[_]%[_]INBOX') 
 	INNER JOIN CADIS_SYS.DM_SOURCE dms
	    ON (dms.MATCHPOINTID = dm.IDENTIFIER
	    AND obj.name = 'DM_MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_' + dms.SHORTNAME + '_INBOX')
    WHERE (dm.OBSOLETE > 0
       OR dms.OBSOLETE > 0)
      AND 'MP' + CONVERT(VARCHAR(10),dm.IDENTIFIER) + '_' + dms.SHORTNAME NOT IN 
              (SELECT 'MP' + CONVERT(VARCHAR(10),dm1.IDENTIFIER) + '_' + dms1.SHORTNAME 
                 FROM CADIS_SYS.DM_MATCHPOINT dm1
               INNER JOIN CADIS_SYS.DM_SOURCE dms1
 	          ON dms1.MATCHPOINTID = dm1.IDENTIFIER
               WHERE dm1.OBSOLETE = 0 AND dms1.OBSOLETE = 0)
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
			SELECT @return=@@error,@errmsg='DM: Clear Obsolete Views'; 
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
