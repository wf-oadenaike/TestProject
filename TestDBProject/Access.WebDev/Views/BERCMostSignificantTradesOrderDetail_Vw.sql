
CREATE  VIEW [Access.WebDev].[BERCMostSignificantTradesOrderDetail_Vw]
/******************************
** Desc: Returns trades and their deviations from benchmarks for previous calendar month
** Auth: W.Stubbs
** Date: 05/01/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1570     05/01/2018  W.Stubbs	Initial version of code
** DAP-1764		06/02/2018	W.Stubbs	Point to deagg data, reasoncodes and thresholds in tables
** DAP-1798		15/02/2018	R.Walker	Expose Reason Codes & Description
** DAP-1570		23/02/2018	W.Stubbs	Vague requirements change
** DAP-1570		12/03/2018	W.Stubbs	PL field added
** DAP-1570		13/04/2018	R.Walker	Fix missing Security Name and weightedaverage permformance figures
** DAP-2144		29/06/2018	R.Walker	Use T_BBG_BROKER instead of static T_BLOOMBERG_BROKERINFO
** DAP-2176		11/07/2018	R.Walker	Restrict IPO trades from Exception analysis 
*******************************/
AS


WITH Benchmarks AS 
( 
SELECT	OrderID,
		MAX([Broker]) AS [Broker],
		COUNT (DISTINCT BROKER) AS Broker_Count,
		MAX(Country) AS Country, 
		REPLACE(Benchmark, 'IS/','') AS Benchmark, 
		MAX(BenchmarkTotal) AS BenchmarkTotal, 
		MAX(PL) AS PL, 
		MAX(Total_Value_By_Order) AS Total_Value,
		SUM(PerformancePCT) AS WeightedPerformance, 
		MAX([Year]) AS [Year], 
		MAX([Month]) AS [Month],
		MAX(Symbol) AS Symbol,
		MAX(ReasonCode) AS ReasonCode,
		MAX(AsOfDate) AS AsOfDate,
		MAX(ASAtDate) AS AsAtDate
		
FROM
	(SELECT OrderID, 
			Benchmark, 
			MIN(Country) OVER (PARTITION BY OrderID, Benchmark) AS Country, 
			SUM(BenchmarkTotal) OVER (PARTITION BY OrderID, Benchmark) AS BenchmarkTotal, 
			SUM(PLPos + PLNeg) OVER (PARTITION BY OrderID, Benchmark) AS PL,
			Performance,  -- debug
			SUM(Total_Value) OVER (PARTITION BY OrderID, Benchmark) AS Total_Value_By_Order,
			(Total_Value / SUM(Total_Value) OVER (PARTITION BY OrderID, Benchmark)) * Performance AS PerformancePCT , -- Should we use BenchmarkTotal or Total Value to cal a weighted average ?
			YEAR(MAX(Trader_date_time) OVER (PARTITION BY OrderID, Benchmark)) AS [Year],
			MONTH(MAX(Trader_date_time) OVER (PARTITION BY OrderID, Benchmark)) AS [Month],
			[Broker],
			Symbol, 
			ReasonCode,
			AsOfDate,
			ASAtDate	
	 FROM [dbo].[Vw_BenchmarkValues]
	 WHERE Benchmark IN ('IS/ACE', 'VWAP')
		AND ISNULL(ReasonCode,'') <> 'IP') bm
GROUP BY OrderID, Benchmark
)
SELECT DISTINCT -- T_MASTER_SEC can have multiple instruments with the same ISIN/SEDOL/CUSIP
    bm.OrderId,
    Security_Name = COALESCE(sec.Security_Name, bm.Symbol),
    [Broker] = IIF(Broker_Count > 1, 'MULTIPLE', COALESCE(BBI.Broker_Short_Name, bm.[Broker])),
    bm.Country,
    TotalValue = Total_Value,
	PerformanceBPS = CAST(bm.WeightedPerformance AS DECIMAL(18,2)) * 100,
    TCAException = tvf.[Message],
    bm.Benchmark,
	ReasonCode = rc.[Description],
	ReasonCodeDescriptive = rc.Narrative,
	bm.BenchmarkTotal,
	bm.PL,
	bm.[Year],
	bm.[Month],
	AsOfDate,
	AsAtDate
FROM 
    Benchmarks bm
LEFT OUTER JOIN [dbo].[Vw_SecuritySourceIDs] ids
ON bm.Symbol = ids.SECURITY_ID
LEFT OUTER JOIN   dbo.T_MASTER_SEC   sec 
	ON ids.EDM_SEC_ID = sec.EDM_SEC_ID
LEFT OUTER JOIN dbo.T_BBG_BROKER BBI
	ON bm.[Broker] = BBI.[Broker] 
LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
	ON bm.ReasonCode = rc.Description
OUTER APPLY dbo.ufn_DetectTCAException(bm.Country,IIF(bm.Benchmark = 'ACE', bm.WeightedPerformance, 0), IIF(bm.Benchmark = 'VWAP', bm.WeightedPerformance, 0), DEFAULT) AS tvf
WHERE tvf.Benchmark = bm.Benchmark







