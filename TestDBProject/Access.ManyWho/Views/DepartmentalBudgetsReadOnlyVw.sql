CREATE VIEW [Access.ManyWho].[DepartmentalBudgetsReadOnlyVw]
	AS 
SELECT
	    db.DepartmentBudgetId
	  , db.DepartmentId
	  , d.DepartmentName
	  , DATEADD(year, db.CalendarYear-1900, DATEADD(month, db.MonthNumber-1, DATEADD(day, 0, 0))) as BudgetDate
	  , DateName( month , DateAdd( month, db.MonthNumber , 0 ) - 1 ) as CalendarMonth
	  , db.CalendarYear
	  , CAST(ROUND(ISNULL(db.ActualAmount,0),0) as bigint) as ActualAmount
	  , CAST(ROUND(ISNULL(db.ForecastAmount,0),0) as bigint) as ForecastAmount
	  , db.DepartmentalBudgetCreationDatetime
	  , db.DepartmentalBudgetLastModifiedDatetime
  FROM [Investment].[DepartmentalBudgets] db
  INNER JOIN [Core].[Departments] d
  ON db.DepartmentId = d.DepartmentId
;
