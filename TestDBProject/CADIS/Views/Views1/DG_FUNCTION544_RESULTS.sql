CREATE VIEW "CADIS"."DG_FUNCTION544_RESULTS" AS 
SELECT ET."Broker",ET."SortOrder",ET."Year",ET."Month",ET."TotalCommission",ET."TotalNotionalValue",ET."BlendedCommissionRate",ET."Country",ET."AsAtDate",ET."AsOfDate" FROM "Access.WebDev"."BERCMonthlyCommissionByBrokerVw" ET WITH (NOLOCK)
