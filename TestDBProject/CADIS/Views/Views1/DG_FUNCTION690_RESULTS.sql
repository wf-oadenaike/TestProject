CREATE VIEW "CADIS"."DG_FUNCTION690_RESULTS" AS 
SELECT ET."TradeYearMonth",ET."Broker",ET."TradeYear",ET."TradeMonth",ET."BrokerUniqueRef",ET."TradeCount",ET."FailTradeCount",ET."PercentageShare",ET."PercentageShareTotal",ET."MonthlyTotal",ET."LastUpdatedDate",ET."CategoryCount" FROM "Access.WebDev"."FailedTradesByBrokerVw" ET WITH (NOLOCK)
