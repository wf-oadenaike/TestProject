﻿CREATE VIEW "CADIS"."DI_VTMASSEC_MASTER_RSLT" AS
SELECT
	RESULT."SECURITY_DESCRIPTION Populated?",RESULT."SECURITY_NAME Populated?",RESULT."CADIS_SYSTEM_CHANGEDBY",RESULT."CADIS_SYSTEM_INSERTED",RESULT."CADIS_SYSTEM_UPDATED",INPUT."EDM_SEC_ID",INPUT."SECURITY_NAME",INPUT."SECURITY_DESCRIPTION",INPUT."SECURITY_SHORTNAME",INPUT."ASSET_TYPE",INPUT."SECURITY_TYPE",INPUT."CUSIP",INPUT."ISIN",INPUT."SEDOL",INPUT."TICKER",INPUT."VALOREN",INPUT."WERTPAPIER",INPUT."SECURITY_ISO_CCY",INPUT."RISK_ISO_CCY",INPUT."FIXED_ISO_CCY",INPUT."INCORPORATION_ISO_CTY",INPUT."DOMICILE_ISO_CTY",INPUT."ISSUE_COUNTRY_ISO",INPUT."RISK_ISO_CTY",INPUT."MIC_EXCHANGE_CODE",INPUT."BBG_EXCHANGE_CODE",INPUT."STATE_CODE",INPUT."ACTIVE_TRADE_INDICATOR",INPUT."144A_INDICATOR",INPUT."PRIVATE_PLACEMENT_INDICATOR",INPUT."ILLIQUID",INPUT."QUOTE_TYPE",INPUT."DAYS_TO_SETTLE",INPUT."TRADE_SETTLEMENT_CALENDAR_CODE",INPUT."CADIS_SYSTEM_UPDATED" "CADIS_SYSTEM_UPDATED0",INPUT."UNIQUE_BLOOMBERG_ID",INPUT."BBG_SECTOR",INPUT."BBG_SUBSECTOR",INPUT."BBG_GROUP",INPUT."IS_IPO",INPUT."PARSEKEYABLE_DESCRIPTION",INPUT."SECURITY_IDENTIFIER",INPUT."IRISH_SEDOL_NUMBER",INPUT."ISSUER",INPUT."CUR_MAR_CAP",INPUT."PRIMARY_EXCHANGE_NAME",INPUT."CADIS_SYSTEM_INSERTED" "CADIS_SYSTEM_INSERTED0",INPUT."CADIS_SYSTEM_CHANGEDBY" "CADIS_SYSTEM_CHANGEDBY0",INPUT."CADIS_SYSTEM_PRIORITY",INPUT."CADIS_SYSTEM_LASTMODIFIED",INPUT."SECURITY_HAS_ADRS",INPUT."WITHHOLDING_TAX",INPUT."VOL_AVG_5D",INPUT."VOL_AVG_20D",INPUT."EDM_ISSUER_ID"
FROM 
"CADIS_PROC"."DI_VTMASSEC_RESULTS" RESULT
JOIN
"dbo"."T_MASTER_SEC" AS INPUT ON
RESULT."EDM_SEC_ID"=INPUT."EDM_SEC_ID" AND
(1=1)
