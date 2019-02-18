CREATE VIEW [Access.ManyWho].[DepartmentalBudgetsLastYearReadOnlyVw]
	AS 
SELECT
        db.DepartmentBudgetId
	  , db.DepartmentId
	  , d.DepartmentName
	  , DATEADD(year, db.CalendarYear-1900, DATEADD(month, db.MonthNumber-1, DATEADD(day, 0, 0))) as BudgetDate
	  , DATENAME( month , DATEADD( month, db.MonthNumber , 0 ) - 1 ) as CalendarMonth
	  , db.CalendarYear
	  , CAST(ROUND(ISNULL(db.ActualAmount,0),0) as bigint) as ActualAmount
	  , CAST(ROUND(ISNULL(db.ForecastAmount,0),0) as bigint) as ForecastAmount
	  , CAST(ROUND((ISNULL(db.ForecastAmount,0) - ISNULL(db.ActualAmount,0)),0) as bigint) as ActualDiff
	  , CASE WHEN (ISNULL(db.ForecastAmount,0) - ISNULL(db.ActualAmount,0)) < 0 THEN 'Overspent' WHEN (ISNULL(db.ForecastAmount,0) - ISNULL(db.ActualAmount,0))> 0 THEN 'Underspent' ELSE 'On Target' END as ActualDiffCategory
	  , db.DepartmentalBudgetCreationDatetime
	  , db.DepartmentalBudgetLastModifiedDatetime
  FROM [Investment].[DepartmentalBudgets] db
  INNER JOIN [Core].[Departments] d
  ON db.DepartmentId = d.DepartmentId
  WHERE DATEADD(year, db.CalendarYear-1900, DATEADD(month, db.MonthNumber-1, DATEADD(day, 0, 0))) 
	BETWEEN DATEADD(day,1,EOMONTH(dateadd(m,-12,getdate()),-1)) AND DATEADD(day,1,EOMONTH(dateadd(m,-1,getdate()),-1))

;
  
