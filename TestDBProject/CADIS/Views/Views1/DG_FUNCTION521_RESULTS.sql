CREATE VIEW "CADIS"."DG_FUNCTION521_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."TotalValue",ET."NumberOfOrders",ET."AsAtDate",ET."AsOfDate" FROM "Access.WebDev"."BERCMonthlyOrderValueVolumeSummaryVw" ET WITH (NOLOCK)
