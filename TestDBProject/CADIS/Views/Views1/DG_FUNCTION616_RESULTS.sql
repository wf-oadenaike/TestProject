CREATE VIEW "CADIS"."DG_FUNCTION616_RESULTS" AS 
SELECT ET."YEAR",ET."MONTH",ET."Benchmark",ET."PositiveTotal",ET."NegativeTotal",ET."Balance" FROM "Access.WebDev"."BERCTotalBenchmarkValuesLast12Months" ET WITH (NOLOCK)
