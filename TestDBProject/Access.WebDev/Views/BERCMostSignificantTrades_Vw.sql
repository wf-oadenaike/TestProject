
CREATE VIEW [Access.WebDev].[BERCMostSignificantTrades_Vw]
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
*******************************/
AS


WITH TCA AS
(
SELECT * FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED]
WHERE Trade_Date_time BETWEEN
(SELECT DATEADD(month, DATEDIFF(month, -1, getdate()) -2, 0)) -- FirtDayPreviousMonthWithTimeStamp,
    AND (SELECT DATEADD(ss, -1, DATEADD(month, DATEDIFF(month, 0, getdate()), 0)) ) -- LastDayPreviousMonthWithTimeStamp
)
SELECT
    X.OrderId,
    X.Security_Name,
    X.[Broker],
    X.Country,
    X.TotalValue,
    X.PerformanceBPS,
    X.TCAException,
    X.Benchmark,
    Y.Concatenated As Slackcommentary,
    X.ReasonCode,
	X.ReasonCodeDescriptive,
	X.BenchmarkTotal,
	X.PL
FROM
 (   SELECT  
        TCA.OrderId,
        Security_Name = COALESCE(MIN(S.Security_Name),MIN(tca.Symbol)),
        [Broker] = COALESCE(MIN(BBI.Broker_Short_Name), MIN(TCA.[Broker])),
        Country = MIN(TCA.COUNTRY),
        TotalValue = SUM(TCA.TOTAL_VALUE),
		PerformanceBPS = CAST(MIN( CASE WHEN TCA.COUNTRY = 'US' THEN TCA.B2NetPctCst ELSE TCA.B1NetPctCst END)*100 AS decimal(18,2) ),
        TCAException = MIN(tvf.Message),
        Benchmark = COALESCE(MIN(tvf.Benchmark),CASE WHEN MIN(TCA.COUNTRY) = 'US' THEN 'VWAP' ELSE 'ACE' END),
		ReasonCode = MIN(rc.Description),
		ReasonCodeDescriptive = MIN(rc.Narrative),
		BenchmarkTotal = SUM (TCA.TOTAL_VALUE) + SUM(CASE WHEN TCA.COUNTRY = 'US' THEN TCA.B2NETREALDOLLAR ELSE TCA.B1NETREALDOLLAR END),
		PL =  SUM(CASE WHEN TCA.COUNTRY = 'US' THEN TCA.B2NETREALDOLLAR ELSE TCA.B1NETREALDOLLAR END)
    FROM 
        TCA
    LEFT OUTER JOIN   dbo.T_MASTER_SEC   S 
		ON tca.Symbol = S.ISIN
	LEFT OUTER JOIN	dbo.T_BLOOMBERG_BROKERINFO	BBI
		ON TCA.BROKER = BBI.Broker_ID
	LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
		ON tca.ReasonCode = rc.Description
	OUTER APPLY dbo.ufn_DetectTCAException(tca.Country,tca.B1NETPCTCST, tca.B2NETPCTCST, DEFAULT) AS tvf

    GROUP BY 
        TCA.OrderId) X

left outer join

(select innerquery.orderiD, innerquery.Concatenated from
(SELECT distinct
    OrderID,
    STUFF((
        SELECT ';'+ISNULL(Narrative,'')
        FROM [TCA].[TCANarrativeEvents] t2
        WHERE t2.OrderID = t1.OrderID
		order by eventdate asc
        FOR XML PATH('')
		
    ), 1,1,'') Concatenated
FROM TCA t1 ) innerquery) y
on X.ORDERID = y.OrderId







