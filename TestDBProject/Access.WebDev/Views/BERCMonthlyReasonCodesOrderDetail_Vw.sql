CREATE VIEW [Access.WebDev].[BERCMonthlyReasonCodesOrderDetail_Vw]
AS
/******************************
** Desc:
** Auth: D.Fanning
** Date: 30/10/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1405     30/10/2017  D.Fanning   Initial version of view
** OSPREY-1669	12/12/2017	W.Stubbs	Change Performance to BPS rather than percentage
** DAP-1568		13/12/2017	W.Stubbs	Replace broker code with broker name where available
** DAP-1619		19/12/2017	W.Stubbs	Refactor to prevent erroneous duplications
** OSPREY-1841	12/01/2018	W.Stubbs	Reorder slack commentary by eventdate
** DAP-1764		06/02/2018  W.Stubbs	Point at deagg data, and reasoncode and benchmarks in tables
** OSPREY-2034	14/02/2018	W.Stubbs	Tweaks after requirements refinement
** DAP-1798		15/02/2018	R.Walker	Expose Reason Codes & Description plus restrict to RC's between 1 to 8
** OSPREY-1914	30/04/2018	R.Walker	Add OrderDate - take the earliest date for that order
** DAP-2092		12/06/2018	R.Walker	Rewrite / refactor view migrate to new name
** DAP-2356		01/10/2018	R.Walker	Take into consideration the Reason codes filter when counting Brokers
*******************************/
WITH CTE_Performance AS
   		( SELECT OrderID, 
				Benchmark, 
				Total_Value / SUM(Total_Value) OVER (PARTITION BY year(Allocated_Time), month(Allocated_Time), OrderId, Benchmark) * Performance AS WeightedPerformance 
			FROM [dbo].[Vw_BenchmarkValues]
			WHERE Benchmark IN ('IS/ACE', 'VWAP')
		),
	CTE_Broker AS
   		(	SELECT	COUNT(DISTINCT Broker) AS BrokerCount,
					OrderID, 
					Benchmark
			FROM [dbo].[Vw_BenchmarkValues] bm
			INNER JOIN dbo.T_BBG_ReasonCode rc
				ON bm.ReasonCode = rc.Description
			WHERE Benchmark IN ('IS/ACE', 'VWAP') 
				AND  rc.Code BETWEEN 1 AND 8
			GROUP BY OrderID, Benchmark
		)
SELECT
    X.[Year],
    X.[Month],
	X.[OrderDate],
    X.OrderId,
    X.Security_Name,
    X.[Broker],
    X.Country,
    X.TotalValue,
    X.Performance * 100 AS Performance,
    ISNULL(tvf.Message, '-') AS TCAException,
    X.Benchmark,
	X.ReasonCode,
	X.ReasonCodeDescriptive
FROM
(
    SELECT  
         YEAR(bm.Allocated_Time)							AS 'Year'
		,MONTH(bm.Allocated_Time)							AS 'Month'
		,MIN(CONVERT(DATE, bm.Allocated_Time, 20))			AS 'OrderDate'
		,bm.OrderId											AS 'OrderID'
        ,MIN(COALESCE(sec.Security_Name,bm.Symbol))			AS 'Security_Name'
		,IIF(MAX(BrokerCount) > 1, 'MULTIPLE',							
			MIN(COALESCE(BBI.Broker_Short_Name, bm.[Broker])))	AS 'Broker'
        ,MIN(bm.Country)									AS 'Country'
		,SUM(bm.Total_Value)								AS 'TotalValue'
		,SUM(bm.Performance) 								AS 'Performance'
        ,REPLACE(bm.Benchmark,'IS/','')						AS 'Benchmark'
		,MIN(rc.Description)								AS 'ReasonCode'
		,MIN(rc.Narrative)									AS 'ReasonCodeDescriptive'
    FROM 
        [dbo].[Vw_BenchmarkValues] bm
	INNER JOIN 
		CTE_Broker brkr
	ON bm.OrderID = brkr.OrderID
		AND bm.Benchmark = brkr.Benchmark
	INNER JOIN 
		(SELECT OrderID, Benchmark, SUM(WeightedPerformance) AS Performance FROM CTE_Performance GROUP BY OrderID, Benchmark) wgt
	ON bm.OrderID = wgt.OrderID
		AND bm.Benchmark = wgt.Benchmark
	LEFT OUTER JOIN   dbo.Vw_SecuritySourceIDs sids
	ON bm.Symbol = sids.SECURITY_ID
	LEFT OUTER JOIN   dbo.T_MASTER_SEC sec
	ON sids.EDM_SEC_ID = sec.EDM_SEC_ID
	LEFT OUTER JOIN
	dbo.T_BBG_BROKER BBI
	ON bm.BROKER = BBI.Broker
	LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
		ON bm.ReasonCode = rc.Description
	WHERE rc.Code BETWEEN 1 AND 8
		AND bm.Benchmark IN ('IS/ACE', 'VWAP')
    GROUP BY 
        year(bm.Allocated_Time),
        month(bm.Allocated_Time),
        bm.OrderId,
		bm.Benchmark
) X
OUTER APPLY dbo.ufn_DetectTCAException(X.Country,IIF(X.Benchmark = 'ACE', X.Performance, 0), IIF(X.Benchmark = 'VWAP', X.Performance, 0), DEFAULT) AS tvf

 





