CREATE VIEW "CADIS"."DG_FUNCTION520_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."Idx",ET."Security_Name",ET."TotalValue",ET."NumberOfOrders",ET."BuySellFlag",ET."TotalTradePct",ET."AsAtDate",ET."AsOfDate" FROM "Access.WebDev"."BERCMonthlyOrderValueSummaryBySecurityVw" ET WITH (NOLOCK)
