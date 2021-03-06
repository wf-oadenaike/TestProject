﻿CREATE VIEW CADIS_SYS.VW_ALL_PROCESSES
--WITH ENCRYPTION--cadisbuild
AS
SELECT A.*, B.NAME AS COMPONENT_NAME
FROM (
	SELECT 0 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LOCKKEY
	FROM CADIS_SYS.DP_DATAPORT
	UNION ALL
	SELECT 1 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LOCKKEY
	FROM CADIS_SYS.DI_INSPECTION
	UNION ALL
	SELECT IDENTIFIERS.COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.DM_MATCHPOINT						
	CROSS JOIN (SELECT 2 AS COMPONENTID UNION SELECT 3 UNION SELECT 4 UNION SELECT 32) IDENTIFIERS
	UNION ALL
	SELECT 5 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LOCKKEY
	FROM CADIS_SYS.DC_CONSTRUCTION
	UNION ALL
	SELECT 6 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=ObjectName, Info2=TypeID, [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.IL_ILLUSTRATION
	UNION ALL
	SELECT 7 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.IL_ILLUSTRATIONTYPE
	UNION ALL
	SELECT 8 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1, Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.CO_SOLUTION
	UNION ALL
	SELECT IDENTIFIERS.COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.DG_FUNCTION
	CROSS JOIN (SELECT 11 AS COMPONENTID UNION SELECT 12) IDENTIFIERS
	UNION ALL
	SELECT IDENTIFIERS.COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.MG_FUNCTION
	CROSS JOIN (SELECT 13 AS COMPONENTID UNION SELECT 14) IDENTIFIERS
	UNION ALL
	SELECT 15 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.EW_EVENTWATCH
	UNION ALL
	SELECT 16 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.PL_PROCESSLAUNCH
	UNION ALL
	SELECT 17 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1, Info2, [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.RB_FUNCTION
	UNION ALL
	SELECT 24 AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1=CONVERT(nvarchar,null), Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LockKey=CONVERT(nvarchar, null)
	FROM CADIS_SYS.DGM_DIAGRAM
	UNION ALL
	SELECT PROCESSTYPE AS COMPONENTID, IDENTIFIER, GUID, NAME, CODE, OBSOLETE, INSERTED, UPDATED, CHANGEDBY, DEFINITION, CRC, Info1, Info2=CONVERT(nvarchar,null), [ENABLED], [TIMECODE], LOCKKEY
	FROM CADIS_SYS.CO_PROCESS
) A
INNER JOIN CADIS_SYS.CO_COMPONENT B ON A.COMPONENTID = B.ID
