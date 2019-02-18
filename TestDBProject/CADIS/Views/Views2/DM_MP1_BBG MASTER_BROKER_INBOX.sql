﻿CREATE VIEW "CADIS"."DM_MP1_BBG MASTER_BROKER_INBOX" AS 
SELECT convert(tinyint,1) as "DM__Status",
	'BBG MASTER_BROKER' as "DM__Source",
	'MASTER_BROKER_NUMBER: '+CONVERT(VARCHAR(8000),SR."MASTER_BROKER_NUMBER") as "DM__Source Key",
	RS.CADISID as "Proposed Cadis Id",
	SR."CADIS Id" as "Assigned Cadis Id",
	CONVERT(TINYINT,RS.PRIORITY) as "DM__Priority",
	RS.INSERTED as "Matched Date",
	RS.CHANGEDBY as "Matched By",
	RS.SOURCEROWID as "Source Row Id",
	SR.*,
	6 as "DM__Source Id"
	FROM "CADIS_PROC"."DM_MP1_RESULT" RS
	INNER JOIN "CADIS"."DM_PARTY_BBG_MASTER_INFO" SR ON SR."CADIS Row Id" = RS.SOURCEROWID
	WHERE RS.SOURCEID = 6
	AND RS.PROVISIONAL = 1
