CREATE VIEW "CADIS"."DG_FUNCTION348_RESULTS" AS 
SELECT ET."Fund_Short_Name",ET."TradeBuySell",ET."AsOfTradeDate",ET."Security_Name",ET."SecurityCurrencyISOCode",ET."TotalTradedAmount",ET."SettlementCcyPrincipal_LocalCCY",ET."SettlementCcyPrincipal_GBP",ET."AveragePrice_LocalCCY",ET."Spot_Rate" FROM "Access.WebDev"."ufn_TradingReport"(NULL, NULL) ET
