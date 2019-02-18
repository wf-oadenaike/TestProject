CREATE VIEW "CADIS"."DG_FUNCTION507_RESULTS" AS 
SELECT ET."AsOfTradeDate",ET."Fund_Short_Name",ET."TradeBuySell",ET."Security_Name",ET."SecurityCurrencyISOCode",ET."TotalTradedAmount",ET."SettlementCcyPrincipal_LocalCCY",ET."SettlementCcyPrincipal_GBP",ET."AveragePrice_LocalCCY",ET."Spot_Rate",ET."DB_UpdatedDateTime" FROM "Access.WebDev"."ufn_TradingReport_v2"(NULL, NULL) ET
