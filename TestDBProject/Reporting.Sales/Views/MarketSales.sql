

CREATE VIEW [Reporting.Sales].[MarketSales]
	AS
WITH LatestQtr AS (
    SELECT cal.[FiscalQuarterName] + '-' + CAST(cal.[FiscalYear] as Varchar) as FiscalQtr
	     , cal.[FiscalFirstDayOfQuarter]
		 , cal.[FiscalLastDayOfQuarter]
		 , mfc.MaxDate as LatestDate
	FROM (SELECT MAX([As_at_Date]) as MaxDate 
	      FROM [Sales].[FinancialClarity]) mfc
	INNER JOIN [Core].[Calendar] cal
	ON mfc.MaxDate = cal.[CalendarDate] )
SELECT 'Equity Income' AS Market
	,  p.PersonsName as Salesperson
	, p.PersonId AS SalespersonId
	, r.RegionName as Region
	, lq.FiscalQtr as FiscalQuarter
	, lq.LatestDate AS [LatestDate]
	, SUM(ISNULL([UK_Equity_Income_Own_Gross_Sales],0)) AS [ActualGross]
	, SUM(ISNULL([UK_Equity_Income_Own_Net_Sales],0)) AS [ActualNet]
	, CAST(NULL AS DECIMAL(19,2)) AS [Target]
	, SUM(ISNULL([UK_Equity_Income_Market_Gross_Sales],0)) AS [MarketSalesGross]
    , SUM(ISNULL([UK_Equity_Income_Market_Net_Sales],0)) AS [MarketSalesNet]
	FROM [Sales].[FinancialClarity] fc
	INNER JOIN LatestQtr lq
	ON fc.[As_at_Date] BETWEEN lq.[FiscalFirstDayOfQuarter] AND lq.[FiscalLastDayOfQuarter]
	INNER JOIN [Sales.BP].[SfAccountVw] acc 
	ON acc.SfAccountId = fc.[SalesforceAccountId] collate SQL_Latin1_General_CP1_CS_AS
	LEFT JOIN
		[Sales.BP].[Region] r ON r.[RegionId] = left(acc.RegionId,1)
	INNER JOIN
		[Core].[Persons] p ON p.[FullEmployeeBK] = acc.[AccountOwnerId]
	INNER JOIN 
		[Core].[Departments] d ON p.[DepartmentId] = d.[DepartmentId]
	WHERE p.[ActiveFlag] = 1 AND d.[ActiveFlag] = 1
	AND d.DepartmentName = 'Sales - Retail'
	AND  acc.RegionId != 'Unallocated'
 GROUP BY p.PersonsName
	    , p.PersonId 
	    , r.RegionName
	    , lq.FiscalQtr
	    , lq.LatestDate
UNION ALL
SELECT 'Equity Income' AS Market
	, p.PersonsName as Salesperson
	, p.PersonId AS SalespersonId
	, r.RegionName as Region
	, lq.FiscalQtr as FiscalQuarter
	, lq.LatestDate AS [LatestDate]
	, SUM(ISNULL([UK_Equity_Income_Own_Gross_Sales],0)) AS [ActualGross]
	, SUM(ISNULL([UK_Equity_Income_Own_Net_Sales],0)) AS [ActualNet]
	, CAST(NULL AS DECIMAL(19,2)) AS [Target]
	, SUM(ISNULL([UK_Equity_Income_Market_Gross_Sales],0)) AS [MarketSalesGross]
    , SUM(ISNULL([UK_Equity_Income_Market_Net_Sales],0)) AS [MarketSalesNet]
	FROM [Sales].[FinancialClarity] fc
	INNER JOIN LatestQtr lq
	ON fc.[As_at_Date] BETWEEN lq.[FiscalFirstDayOfQuarter] AND lq.[FiscalLastDayOfQuarter]
	INNER JOIN [Sales.BP].[SfAccountVw] acc 
	ON acc.SfAccountId = fc.[SalesforceAccountId]
	LEFT JOIN
		[Sales.BP].[Region] r ON r.[RegionId] = left(acc.RegionId,1)
	INNER JOIN
		[Core].[Persons] p ON p.[FullEmployeeBK] = acc.[AccountOwnerId]
	INNER JOIN 
		[Core].[Departments] d ON p.[DepartmentId] = d.[DepartmentId]
	WHERE p.[ActiveFlag] = 1 AND d.[ActiveFlag] = 1
	AND d.DepartmentName = 'Sales - Retail'
	AND  acc.RegionId != 'Unallocated'
 GROUP BY p.PersonsName
	    , p.PersonId 
	    , r.RegionName
	    , lq.FiscalQtr
	    , lq.LatestDate
;

