﻿CREATE VIEW "CADIS"."DM_MP2_BLOOMBERG_INBOX" AS 
SELECT convert(tinyint,1) as "DM__Status",
	'BLOOMBERG' as "DM__Source",
	'UNIQUE_IDENTIFIER: '+CONVERT(VARCHAR(8000),SR."UNIQUE_IDENTIFIER") as "DM__Source Key",
	RS.CADISID as "Proposed Cadis Id",
	SR."CADIS Id" as "Assigned Cadis Id",
	CONVERT(TINYINT,RS.PRIORITY) as "DM__Priority",
	RS.INSERTED as "Matched Date",
	RS.CHANGEDBY as "Matched By",
	RS.SOURCEROWID as "Source Row Id",
	SR.*,
	20 as "DM__Source Id"
	FROM "CADIS_PROC"."DM_MP2_RESULT" RS
	INNER JOIN "CADIS"."DM_SECURITY_BLOOMBERG_INFO" SR ON SR."CADIS Row Id" = RS.SOURCEROWID
	WHERE RS.SOURCEID = 20
	AND RS.PROVISIONAL = 1