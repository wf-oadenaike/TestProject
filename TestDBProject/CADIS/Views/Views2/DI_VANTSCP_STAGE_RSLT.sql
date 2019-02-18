﻿CREATE VIEW "CADIS"."DI_VANTSCP_STAGE_RSLT" AS
SELECT
	RESULT."EDM_SHARECLASS_ID Populated?",RESULT."Primary Key Unique?",RESULT."All Tests Passed?",RESULT."CADIS_SYSTEM_CHANGEDBY",RESULT."CADIS_SYSTEM_INSERTED",RESULT."CADIS_SYSTEM_UPDATED",INPUT."PK_RANK",INPUT."PK_COLUMNS",INPUT."PK_VALUE",INPUT."SOURCE_COMPONENT",INPUT."ID",INPUT."EDM_SHARECLASS_ID",INPUT."VALUATION_DATE",INPUT."SHARE_CLASS_NAME",INPUT."ISIN",INPUT."XD",INPUT."EXIT_CHARGE_PERCENT",INPUT."INITIAL_CHARGE_PERCENT",INPUT."MID_PRICE",INPUT."PRICE_CHANGE",INPUT."PRICE_MOVE_PERCENT",INPUT."INITIAL_CHARGE",INPUT."HISTORIC_YIELD_PERCENT",INPUT."DISTRIBUTION_YIELD_PERCENT",INPUT."UNDERLYING_YIELD_PERCENT",INPUT."EQUALISATION_RATE",INPUT."UNITS_IN_ISSUE",INPUT."FUND_VALUE",INPUT."CURRENCY",INPUT."CADIS_SYSTEM_INSERTED" "CADIS_SYSTEM_INSERTED0",INPUT."CADIS_SYSTEM_UPDATED" "CADIS_SYSTEM_UPDATED0",INPUT."CADIS_SYSTEM_CHANGEDBY" "CADIS_SYSTEM_CHANGEDBY0",INPUT."CADIS_SYSTEM_RUNID",INPUT."CADIS_SYSTEM_TOPRUNID"
FROM 
"CADIS_PROC"."DI_VANTSCP_RESULTS" RESULT
JOIN
(SELECT 
	ROW_NUMBER() OVER (PARTITION BY [EDM_SHARECLASS_ID],[VALUATION_DATE]
		ORDER BY [EDM_SHARECLASS_ID],[VALUATION_DATE])			AS [PK_RANK],
	'EDM_SHARECLASS_ID,VALUATION_DATE'					AS [PK_COLUMNS],
	 CAST([EDM_SHARECLASS_ID] AS VARCHAR(10)) + ' ' +  
		CAST([VALUATION_DATE] AS VARCHAR(30)) 				AS [PK_VALUE],
	'Validate NT Share Class Price'						AS [SOURCE_COMPONENT],
	* 
FROM "dbo"."T_NT_SHARE_CLASS_PRICE_STAGE") AS INPUT ON
RESULT."ID"=INPUT."ID" AND
(1=1)