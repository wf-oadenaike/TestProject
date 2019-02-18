

CREATE  VIEW [Access.WebDev].[BERCMostSignificantTradesBrokerDetail_Vw]
/******************************
** Desc: Returns order detail at Broker level - Works in tandem with the BERCMostSignificantTrades_Vw
** Auth: R.Walker
** Date: 02/05/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1570     02/05/2018  R.Walker	Initial version of code - Based on BERCMostSignificantTrades_Vw
** DAP-2144		29/06/2018	R.Walker	Use T_BBG_BROKER instead of static T_BLOOMBERG_BROKERINFO
*******************************/
AS

WITH Benchmarks AS 
( 
SELECT	OrderID,
		[Broker],
		REPLACE(Benchmark, 'IS/','') AS Benchmark, 
		MAX(BenchmarkTotal) AS BenchmarkTotal, 
		MAX(PL) AS PL, 
		MAX(Total_Value_By_Broker) AS Total_Value,
		SUM(PerformancePCT) AS WeightedPerformanceByBroker, 
		MAX([Year]) AS [Year], 
		MAX([Month]) AS [Month],
		MAX(Symbol) AS Symbol,
		MAX(ReasonCode) AS ReasonCode
FROM
	(SELECT OrderID,
			[Broker], 
			Benchmark, 
			SUM(BenchmarkTotal) OVER (PARTITION BY OrderID, [Broker], Benchmark) AS BenchmarkTotal, 
			SUM(PLPos + PLNeg) OVER (PARTITION BY OrderID, [Broker], Benchmark) AS PL,
			Performance,  -- debug
			SUM(Total_Value) OVER (PARTITION BY OrderID, [Broker], Benchmark) AS Total_Value_By_Broker,
			(Total_Value / SUM(Total_Value) OVER (PARTITION BY OrderID, Benchmark)) * Performance * 100 AS PerformancePCT , -- Should we use BenchmarkTotal or Total Value to cal a weighted average ?
			YEAR(MAX(Trader_date_time) OVER (PARTITION BY OrderID, Benchmark)) AS [Year],
			MONTH(MAX(Trader_date_time) OVER (PARTITION BY OrderID, Benchmark)) AS [Month],
			Symbol, 
			ReasonCode	
	 FROM [dbo].[Vw_BenchmarkValues]
	 WHERE Benchmark IN ('IS/ACE', 'VWAP') 
			AND Trader_Date_time BETWEEN
		(SELECT CONVERT(VARCHAR(6),DATEADD(month, -13, getdate()),112) + '01') -- FirtDayPreviousMonthWithTimeStamp,
			AND (SELECT DATEADD(ss, -1, DATEADD(month, DATEDIFF(month, 0, getdate()), 0)))) bm
GROUP BY OrderID, [Broker], Benchmark
)
SELECT  
    bm.OrderId,
    Security_Name = COALESCE(sec.Security_Name, bm.Symbol),
    [Broker] = COALESCE(BBI.Broker_Short_Name, bm.[Broker]),
    TotalValue = bm.Total_Value,
	PerformanceBPS = CAST(bm.WeightedPerformanceByBroker AS DECIMAL(18,0)),
    bm.Benchmark,
	ReasonCode = rc.[Description],
	ReasonCodeDescriptive = rc.Narrative,
	bm.BenchmarkTotal,
	bm.PL
FROM 
    Benchmarks bm
LEFT OUTER JOIN [dbo].[Vw_SecuritySourceIDs] ids
ON bm.Symbol = ids.SECURITY_ID
LEFT OUTER JOIN   dbo.T_MASTER_SEC   sec 
	ON ids.EDM_SEC_ID = sec.EDM_SEC_ID
LEFT OUTER JOIN dbo.T_BBG_BROKER BBI
	ON bm.[Broker] = BBI.[Broker] 
LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
	ON bm.ReasonCode = rc.[Description]





