

CREATE VIEW [Contacts].[SuggestedAccountsVw]
	AS
WITH CTE_Dates AS 
(-- SELECT the first day of latest month
SELECT MAX(As_at_Date) AS LatestDate, DATEADD(MM,-1, DATEADD(dd,1,MAX(As_at_Date))) AS FirstDayOfMonth, DATEADD(MM,-2, DATEADD(dd,1,MAX(As_at_Date))) AS FirstDayOfPreviousMonth FROM [Sales].[FinancialClarity]
)
SELECT * FROM (
	SELECT  SfAccountId as AccountId, AccountName, PersonId, PersonsName, RegionName, fcLatest.As_At_Date AS LatestMarketSalesDate, fcPrevious.As_At_Date AS PreviousMarketSalesDate
	, fcLatest.UK_Equity_Income_Market_Gross_Sales AS LatestUKEquityIncomeMarketGrossSales, fcPrevious.UK_Equity_Income_Market_Gross_Sales AS PreviousUKEquityIncomeMarketGrossSales
	, fcLatest.UK_All_Companies_Market_Gross_Sales AS LatestUKAllCompaniesMarketGrossSales, fcPrevious.UK_All_Companies_Market_Gross_Sales AS PreviousUKAllCompaniesMarketGrossSales
	, ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0) AS LatestAllMarketSales
	, ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0) AS PreviousAllMarketSales
	,(CASE WHEN ISNULL(fcLatest.UK_Equity_Income_Market_Gross_Sales,0) - ISNULL(fcPrevious.UK_Equity_Income_Market_Gross_Sales,0) > 100000 THEN 1 ELSE 0 END) AS IsChangeInEquityIncome
	,(CASE WHEN ISNULL(fcLatest.UK_All_Companies_Market_Gross_Sales,0) - ISNULL(fcPrevious.UK_All_Companies_Market_Gross_Sales,0) > 100000 THEN 1 ELSE 0 END) AS IsChangeInAllCompanies
	,(CASE WHEN (CASE WHEN ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcLatest.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0)) ELSE NULL END) -
	(CASE WHEN ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcPrevious.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0)) ELSE NULL END)  >= 0.05
		THEN 1
	ELSE 0 END) AS IsChangeAllMarket
	,ISNULL(fcLatest.UK_Equity_Income_Market_Gross_Sales,0) - ISNULL(fcPrevious.UK_Equity_Income_Market_Gross_Sales,0) AS EquityIncomeDelta
	,ISNULL(fcLatest.UK_All_Companies_Market_Gross_Sales,0) - ISNULL(fcPrevious.UK_All_Companies_Market_Gross_Sales,0) AS AllCompaniesDelta
	,(CASE WHEN ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcLatest.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0)) ELSE NULL END) AS CurrentMarketShare
	,(CASE WHEN ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcPrevious.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0)) ELSE NULL END) AS PreviousMarketShare 
	,(CASE WHEN ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcLatest.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0)) ELSE NULL END) -
	(CASE WHEN ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcPrevious.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0)) ELSE NULL END) AS MarketShareChange
	 
	 ,CONVERT(DECIMAL(5,2),(CASE WHEN ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0) <> 0 THEN ROUND((ISNULL(fcLatest.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0)) * 100.00,2) ELSE NULL END)) AS CurrentMarketSharePrint
	,CONVERT(DECIMAL(5,2),(CASE WHEN ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0) <> 0 THEN ROUND((ISNULL(fcPrevious.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0))* 100.00,2) ELSE NULL END)) AS PreviousMarketSharePrint
	,CONVERT(DECIMAL(5,2),ROUND(((CASE WHEN ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcLatest.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcLatest.[Outlet_Market_Gross_Sales],0)) ELSE NULL END) -
	(CASE WHEN ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0) <> 0 THEN (ISNULL(fcPrevious.[Outlet_Own_Gross_Sales],0)/ ISNULL(fcPrevious.[Outlet_Market_Gross_Sales],0)) ELSE NULL END))* 100.00,2)) AS MarketShareChangePrint 
	 FROM [Sales.BP].[SfAccountVw] wa
	  INNER JOIN [core].[persons] p ON p.FullEmployeeBK = wa.AccountOwnerId
	  LEFT JOIN [Sales.BP].[Region] r ON r.RegionId = left(wa.RegionId,1)
	  CROSS JOIN CTE_Dates dates --ON 1 = 1
	  LEFT JOIN [Sales].[FinancialClarity] fcLatest ON fcLatest.Matrix_Outlet_Id = wa.MatrixOutletId AND dates.LatestDate = fcLatest.As_At_Date
	  LEFT JOIN [Sales].[FinancialClarity] fcPrevious ON fcPrevious.Matrix_Outlet_Id = wa.MatrixOutletId AND dates.FirstDayOfPreviousMonth = DATEADD(MM,-1, DATEADD(dd,1,fcPrevious.As_At_Date)) 
	WHERE wa.RegionId != 'Unallocated'
	and wa.IsPriorityClient = 'false'
) data
WHERE IsChangeInEquityIncome = 1 OR IsChangeInAllCompanies = 1 OR IsChangeAllMarket = 1
