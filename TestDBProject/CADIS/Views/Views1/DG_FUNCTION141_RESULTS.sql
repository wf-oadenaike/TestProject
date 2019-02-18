CREATE VIEW "CADIS"."DG_FUNCTION141_RESULTS" AS 
SELECT ET."DepartmentId",ET."DepartmentName",ET."SumActualAmount",ET."SumForecastAmount",ET."SumActualDiff" FROM "Access.ManyWho"."DepartmentalBudgetsLastYearTotalReadOnlyVw" ET WITH (NOLOCK)
