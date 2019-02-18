CREATE VIEW "CADIS"."DG_FUNCTION764_RESULTS" AS 
SELECT ET."MarketCap",ET."EndWeight",ET."Fund",ET."SOURCE_CODE",ET."AS_AT_DATE" FROM "Access.WebSite"."ufn_GetFundSummaryByMarketCap"(NULL, NULL) ET
