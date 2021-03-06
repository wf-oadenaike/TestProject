﻿CREATE VIEW "CADIS"."DI_VABPSREQA_REQUEST_RSLT" AS
SELECT
	RESULT."Valid ISIN?",RESULT."Valid SEDOL?",RESULT."Valid CUSIP?",RESULT."CADIS_SYSTEM_CHANGEDBY",RESULT."CADIS_SYSTEM_INSERTED",RESULT."CADIS_SYSTEM_UPDATED",INPUT."SOURCE",INPUT."SOURCE_ID",INPUT."REQUEST_ID_TYPE",INPUT."REQUEST_ID",INPUT."REQUEST_REGION",INPUT."BB_EXCHANGE",INPUT."PRICING_SOURCE",INPUT."CADIS_SYSTEM_INSERTED" "CADIS_SYSTEM_INSERTED0",INPUT."CADIS_SYSTEM_UPDATED" "CADIS_SYSTEM_UPDATED0",INPUT."CADIS_SYSTEM_CHANGEDBY" "CADIS_SYSTEM_CHANGEDBY0",INPUT."CADIS_SYSTEM_PRIORITY",INPUT."CADIS_SYSTEM_LASTMODIFIED"
FROM 
"CADIS_PROC"."DI_VABPSREQA_RESULTS" RESULT
JOIN
"dbo"."T_BPS_REQUEST_ALL_OUT" AS INPUT ON
RESULT."SOURCE"=INPUT."SOURCE" AND
RESULT."SOURCE_ID"=INPUT."SOURCE_ID" AND
(1=1)
