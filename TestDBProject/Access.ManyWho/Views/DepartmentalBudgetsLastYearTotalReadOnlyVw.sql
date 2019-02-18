CREATE VIEW [Access.ManyWho].[DepartmentalBudgetsLastYearTotalReadOnlyVw]
	AS 
SELECT
	    db.DepartmentId
	  , d.DepartmentName
	  , CAST(ROUND(SUM(ISNULL(db.ActualAmount,0)),0) as bigint) as SumActualAmount
	  , CAST(ROUND(SUM(ISNULL(db.ForecastAmount,0)),0) as bigint) as SumForecastAmount
	  , CAST(ROUND(SUM(ISNULL(db.ForecastAmount,0)-ISNULL(db.ActualAmount,0)),0) as bigint) as SumActualDiff
	  FROM [Investment].[DepartmentalBudgets] db
  INNER JOIN [Core].[Departments] d
  ON db.DepartmentId = d.DepartmentId
  WHERE DATEADD(year, db.CalendarYear-1900, DATEADD(month, db.MonthNumber-1, DATEADD(day, 0, 0))) 
	BETWEEN DATEADD(day,1,EOMONTH(dateadd(m,-12,getdate()),-1)) AND DATEADD(day,1,EOMONTH(dateadd(m,-1,getdate()),-1))
  GROUP BY db.DepartmentId, d.DepartmentName

;
