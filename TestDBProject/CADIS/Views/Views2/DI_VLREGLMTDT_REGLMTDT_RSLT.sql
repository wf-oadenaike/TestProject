﻿CREATE VIEW "CADIS"."DI_VLREGLMTDT_REGLMTDT_RSLT" AS
SELECT
	RESULT."Is Valid EFFECTIVE_DATE?",RESULT."Is Valid REPORT_DATE ?",RESULT."Is FUND_CODE NOT NULL?",RESULT."Is RULE_ID NOT NULL?",RESULT."Is TICKER NOT NULL?",RESULT."Is IDENTIFIER NOT NULL?",RESULT."Is QUANTITY Valid?",RESULT."Is PRICE Valid?",RESULT."Is IN_VIOLATION flag Valid?",RESULT."Is CONVERTED_EFFECTIVE_DATE Valid int?",RESULT."Is CONVERTED_REPORT_DATE Valid int?",RESULT."All Tests Passed?",RESULT."CADIS_SYSTEM_CHANGEDBY",RESULT."CADIS_SYSTEM_INSERTED",RESULT."CADIS_SYSTEM_UPDATED",INPUT."ROW_ID",INPUT."FUND_CODE",INPUT."RULE_ID",INPUT."TICKER",INPUT."IDENTIFIER",INPUT."QUANTITY",INPUT."PRICE",INPUT."SECURITY_CURRENCY",INPUT."MARKET_VALUE",INPUT."ATTRIBUTE_1",INPUT."ATTRIBUTE_2",INPUT."IN_VIOLATION",INPUT."EFFECTIVE_DATE",INPUT."REPORT_DATE",INPUT."IS_SUBTITLE",INPUT."CONVERTED_EFFECTIVE_DATE",INPUT."CONVERTED_REPORT_DATE",INPUT."CADIS_SYSTEM_INSERTED" "CADIS_SYSTEM_INSERTED0",INPUT."CADIS_SYSTEM_UPDATED" "CADIS_SYSTEM_UPDATED0",INPUT."CADIS_SYSTEM_CHANGEDBY" "CADIS_SYSTEM_CHANGEDBY0",INPUT."CADIS_SYSTEM_PRIORITY"
FROM 
"CADIS_PROC"."DI_VLREGLMTDT_RESULTS" RESULT
JOIN
(SELECT * FROM "dbo"."T_REGULATORY_RULE_DETAIL_STAGE" WHERE /* remove "Rule:" and "Scope:" TICKER rows from the inspection and load as these are the subtitles in the Excel ragged hierarchy */
IS_SUBTITLE <> 1) AS INPUT ON
RESULT."ROW_ID"=INPUT."ROW_ID" AND
(1=1)
