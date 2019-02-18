CREATE VIEW "CADIS"."DG_FUNCTION142_RESULTS" AS 
SELECT ET."DepartmentBudgetId",ET."DepartmentId",ET."DepartmentName",ET."BudgetDate",ET."CalendarMonth",ET."CalendarYear",ET."ActualAmount",ET."ForecastAmount",ET."DepartmentalBudgetCreationDatetime",ET."DepartmentalBudgetLastModifiedDatetime" FROM "Access.ManyWho"."DepartmentalBudgetsReadOnlyVw" ET WITH (NOLOCK)
