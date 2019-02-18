CREATE VIEW "CADIS"."DG_FUNCTION519_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."Country",ET."CountryName",ET."TotalValue",ET."AsOfDate",ET."AsAtDate" FROM "Access.WebDev"."BERCMonthlyOrderValueSummaryByCountryVw" ET WITH (NOLOCK)
