

CREATE	VIEW [Sales.BP].[FCMovementUKIncomeVw] AS

-------------------------------------------------------------------------------------- 
-- Name: UK Income Financial Clarity View [Sales.BP].[FCMovementUKIncomeVw] 
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 Reads Financial Clarity Data from the Matrix refresh file
-- Richard Dixon 05/10/2017 Added PrevDate and CurrDate to view output
-- Vipul Khatri  09/05/2018 DAP-1753 - Updated to use Matrix feed view [Sales.BP].[SfAccountvw]
-------------------------------------------------------------------------------------- 


WITH	Summary AS (

SELECT
		'UKINCOME' as Sector,
		sf.SfAccountId,
		sf.AccountName,
		sf.AccountOwnerId,
		sf.IsPriorityClient,		
		[Matrix_Outlet_id],
		[Outlet_Own_Gross_Sales] as currOutletOwnSales,			
		[As_At_Date] AS CurrDate,
		lag ([As_At_Date]) OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date]) as prevDate,
		lag ([Outlet_Own_Gross_Sales]) OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date]) as prevOuletOwnSales,
		[Outlet_Market_Gross_Sales]  as currOutletMarketSales,
		lag ([Outlet_Market_Gross_Sales]) OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date]) as prevOuletMarketSales,
		ROW_NUMBER() OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date] DESC) as RowNum 	
	
FROM	[Sales.BP].[SfAccountvw] sf
LEFT	OUTER JOIN [ETL].[FinancialClarityVw] fc
ON		fc.SalesforceAccountId = sf.SfAccountId
AND		[UK_Equity_Income_Market_Gross_Sales] is not null
AND		[UK_Equity_Income_Own_Gross_Sales] is not null
AND		[Outlet_Own_Gross_Sales] is not null
AND		[Outlet_Market_Gross_Sales] is not null
AND		AS_at_Date >= dateadd(m,-1,(SELECT MAX(As_at_Date) FROM [Sales].[FinancialClarity]))
)

SELECT 
		Sector,
		SfAccountId,
		AccountName,
		AccountOwnerId,
		IsPriorityClient,
		currOutletOwnSales,
		prevOuletOwnSales,
		currOutletOwnSales - prevOuletOwnSales as SalesMoveValue,	
		currOutletMarketSales,
		prevOuletMarketSales,
		CASE WHEN ISNULL(currOutletMarketSales,0) != 0 THEN (currOutletOwnSales / currOutletMarketSales) * 100 ELSE 0.00 END as CurrMktShare	,
		CASE WHEN ISNULL(prevOuletMarketSales,0) != 0 THEN (prevOuletOwnSales / prevOuletMarketSales) * 100 ELSE 0.00 END as PrevMktShare,
		CASE WHEN ISNULL(currOutletMarketSales,0) != 0 AND ISNULL(prevOuletMarketSales,0) != 0 THEN (((currOutletOwnSales / currOutletMarketSales) * 100) - ((prevOuletOwnSales / prevOuletMarketSales) * 100)) ELSE 0.00 END as MktShareMoveValue,
		prevDate,
		currDate
FROM	Summary
WHERE	rownum = 1
AND		prevOuletOwnSales IS NOT NULL 
AND		prevOuletMarketSales IS NOT NULL
AND		CurrDate = (SELECT MAX(CurrDate) from Summary )