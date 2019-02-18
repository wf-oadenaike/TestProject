﻿CREATE VIEW "CADIS"."DM_MP1_BBG BROKER_INBOX" AS 
SELECT convert(tinyint,1) as "DM__Status",
	'BBG BROKER' as "DM__Source",
	'BROKER: '+CONVERT(VARCHAR(8000),SR."BROKER") as "DM__Source Key",
	RS.CADISID as "Proposed Cadis Id",
	SR."CADIS Id" as "Assigned Cadis Id",
	CONVERT(TINYINT,RS.PRIORITY) as "DM__Priority",
	RS.INSERTED as "Matched Date",
	RS.CHANGEDBY as "Matched By",
	RS.SOURCEROWID as "Source Row Id",
	SR.*,
	5 as "DM__Source Id"
	FROM "CADIS_PROC"."DM_MP1_RESULT" RS
	INNER JOIN "CADIS"."DM_PARTY_BBG_BROKER_INFO" SR ON SR."CADIS Row Id" = RS.SOURCEROWID
	WHERE RS.SOURCEID = 5
	AND RS.PROVISIONAL = 1
