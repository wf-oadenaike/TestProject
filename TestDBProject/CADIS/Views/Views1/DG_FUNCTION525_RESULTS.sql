﻿CREATE VIEW "CADIS"."DG_FUNCTION525_RESULTS" AS 
SELECT ET."ROW_NUM",ET."SECTION",ET."FUND_SHORT_NAME",ET."START_DATE",ET."END_DATE",ET."ASSET_NAME",ET."TICKER",ET."CTR_TO_RTN_PORT" FROM "Access.WebDev"."ufn_BBGFundPerformanceAttributionByFund"(NULL, NULL, NULL) ET
