CREATE VIEW "CADIS"."DG_FUNCTION522_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."Benchmark",ET."PositivePerformanceCount",ET."NegativePerformanceCount" FROM "Access.WebDev"."BERCMonthlyExceptionsSummaryVw" ET WITH (NOLOCK)
