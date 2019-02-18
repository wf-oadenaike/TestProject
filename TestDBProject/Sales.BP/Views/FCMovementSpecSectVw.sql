
CREATE VIEW [Sales.BP].[FCMovementSpecSectVw] AS

-------------------------------------------------------------------------------------- 
-- Name: Specialist Sector Financial Clarity View [Sales.BP].[FCMovementSpecSectVw]
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 Reads Financial Clarity Data from the Matrix refresh file
-- Richard Dixon 05/10/2017 added CurrDate and PrevDate to view output.
-- Vipul Khatri  09/05/2018 DAP-1753 - Updated to use Matrix feed view [Sales.BP].[SfAccountvw]
-------------------------------------------------------------------------------------- 


WITH summary AS (
SELECT
		'SPECSECT' as Sector,
		sf.SfAccountId,
		sf.AccountName,
		sf.AccountOwnerId,
		sf.IsPriorityClient,
		[As_At_Date] AS CurrDate,
		lag ([As_At_Date]) OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date]) as prevDate,
		[Matrix_Outlet_id],	
		ROW_NUMBER() OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date] DESC) as RowNum, 
		fc.[Specialist_Own_Gross_Sales] AS currOutletOwnSales,
		lag (fc.[Specialist_Own_Gross_Sales]) OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date]) AS prevOutletOwnSales,
		fc.[Specialist_Market_Gross_Sales] AS currOutletMarketSales,
		lag (fc.[Specialist_Market_Gross_Sales]) OVER (PARTITION BY [Matrix_Outlet_id] ORDER BY [As_At_Date]) as prevOutletMarketSales

FROM	[Sales.BP].[SfAccountvw] sf
LEFT	OUTER JOIN [ETL].[FinancialClarityVw] fc
ON		fc.SalesforceAccountId = sf.SfAccountId
AND		fc.[Specialist_Own_Gross_Sales] is not null
AND		fc.[Specialist_Market_Gross_Sales] is not null
AND		AS_at_Date >= dateadd(m,-1,(SELECT MAX(As_at_Date) FROM [Sales].[FinancialClarity]))
)

SELECT	Sector,
		SfAccountId,
		AccountName,
		AccountOwnerId,
		IsPriorityClient,
		currOutletOwnSales,
		prevOutletOwnSales,
		currOutletOwnSales - prevOutletOwnSales as SalesMoveValue,	
		currOutletMarketSales,
		prevOutletMarketSales,		
		CASE WHEN ISNULL(currOutletMarketSales,0) != 0 THEN (currOutletOwnSales / currOutletMarketSales) * 100 ELSE 0.00 END as CurrMktShare,
		CASE WHEN ISNULL(prevOutletMarketSales,0) != 0 THEN (prevOutletOwnSales / prevOutletMarketSales) * 100 ELSE 0.00 END as PrevMktShare,		
		CASE WHEN ISNULL(currOutletMarketSales,0) != 0 AND ISNULL(prevOutletMarketSales,0) != 0 THEN (((currOutletOwnSales / currOutletMarketSales) * 100) - ((prevOutletOwnSales / prevOutletMarketSales) * 100)) ELSE 0.00 END as MktShareMoveValue,
		prevDate,
		CurrDate
FROM	summary 
WHERE	rownum = 1
AND		prevOutletOwnSales IS NOT NULL 
AND		prevOutletMarketSales IS NOT NULL
AND		CurrDate = (SELECT MAX(CurrDate) from Summary )	
