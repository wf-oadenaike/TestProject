﻿CREATE VIEW "CADIS"."DG_FUNCTION524_RESULTS" AS 
SELECT ET."ROW_NUM",ET."SECTION",ET."BENCHMARK_NAME",ET."START_DATE",ET."END_DATE",ET."ASSET_NAME",ET."TICKER",ET."CTR_TO_RTN_BNCH" FROM "Access.WebDev"."ufn_BBGFundPerformanceAttributionByBenchmark"(NULL, NULL, NULL) ET
