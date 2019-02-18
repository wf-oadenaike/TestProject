CREATE VIEW "CADIS"."DG_FUNCTION508_RESULTS" AS 
SELECT ET."Fund_Short_Name",ET."Security_Name",ET."SecurityCurrencyISOCode",ET."TotalTradedAmount",ET."SettlementCcyPrincipal_LocalCCY",ET."SettlementCcyPrincipal_GBP",ET."AveragePrice_LocalCCY",ET."Spot_Rate",ET."DB_UpdatedDateTime" FROM "Access.WebDev"."ufn_TradingReportSummary_v1"(NULL, NULL) ET
