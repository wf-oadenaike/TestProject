
CREATE VIEW [Reporting.Sales].[PlannedActualCallsMeetingsVw]
	AS
  SELECT COUNT(*) as ActualsCount
        ,pa.Type
        ,pa.AccountId
		,acc.AccountName
		,p.PersonId AS SalespersonId
		,p.PersonsName AS Salesperson
		,pa.ActivityMonthYear
  FROM 
  (SELECT act.Type
		,act.AccountId
		,act.OwnerId
        ,LEFT(DATENAME ( MONTH , ActivityDate ),3) + ' ' + CAST(YEAR(ActivityDate) AS CHAR(4)) as ActivityMonthYear
  FROM [Sales.BP].[Actual] act
  WHERE act.status='Completed'
  AND act.Type in ('Call','Meeting')
  AND act.ActivityDate is not null
  AND act.IsActive = 1
  INTERSECT
  SELECT fo.Type
		,fo.AccountId
		,fo.OwnerId
        ,LEFT(DATENAME ( MONTH , ActivityDate ),3) + ' ' + CAST(YEAR(ActivityDate) AS CHAR(4)) as ActivityMonthYear
  FROM [Sales.BP].[Forecast] fo
  WHERE fo.Type in ('Call','Meeting')
  AND fo.ActivityDate is not null
  AND fo.IsActive = 1) pa
  INNER JOIN [Sales.BP].[SfAccountVw] acc 
  ON acc.SfAccountId = pa.AccountId 
  LEFT OUTER JOIN [Core].[Persons] p 
  ON p.[FullEmployeeBK] = pa.[OwnerId]

  GROUP BY pa.Type
        ,pa.AccountId
		,acc.AccountName
		,p.PersonId
		,p.PersonsName
		,pa.ActivityMonthYear
;

