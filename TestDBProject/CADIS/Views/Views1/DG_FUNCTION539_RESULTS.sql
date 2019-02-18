CREATE VIEW "CADIS"."DG_FUNCTION539_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."Broker",ET."TotalCommission" FROM "Access.WebDev"."BERCMonthlyCommissionByBrokerVw" ET WITH (NOLOCK)
