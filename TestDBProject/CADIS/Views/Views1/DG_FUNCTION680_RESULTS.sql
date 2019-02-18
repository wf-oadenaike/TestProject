CREATE VIEW "CADIS"."DG_FUNCTION680_RESULTS" AS 
SELECT ET."TradeYearMonth",ET."TradeYear",ET."TradeMonth",ET."TradeCount",ET."FailTradeCount",ET."PercentageShareTotal",ET."MonthlyTotal",ET."LastUpdatedDate",ET."CategoryCount" FROM "Access.WebDev"."FailedTradesVw" ET WITH (NOLOCK)
