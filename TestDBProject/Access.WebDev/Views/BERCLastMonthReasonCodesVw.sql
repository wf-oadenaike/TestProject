
CREATE VIEW [Access.WebDev].[BERCLastMonthReasonCodesVw]
AS
/******************************
** Desc:
** Auth: W.Stubbs
** Date: 08/01/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1650     08/01/2018  W.Stubbs	Initial version of view
** DAP-1764		06/02/2018	W.Stubbs	Major rewrite - use deaggregated data, plus reasoncodes and benchmarks
										now in tables
** DAP-1798		15/02/2018	R.Walker	Expose Reason Codes & Description plus restrict to RC's between 1 to 8
** DAP-2325 		04/10/2018 Add AsAtDate and AsOfDate
*******************************/

WITH CTE as
(
  SELECT distinct OrderID
  FROM [TCA].[TCANarrativeEvents]
)

SELECT
    X.[Year],
    X.[Month],
    X.OrderId,
    X.Security_Name,
    X.[Broker],
    X.Country,
    X.TotalValue,
    X.Performance,
    X.TCAException,
    X.Benchmark,
    Y.Concatenated As Slackcommentary,
    X.ReasonCode,
	X.ReasonCodeDescriptive,
	X.AsAtDate,
	X.AsOfDate
FROM
(
    SELECT  
        [Year] = YEAR(tca.Trade_Date_time),
        [Month] = MONTH(tca.Trade_Date_time),
        TCA.OrderId,
        Security_Name = MIN(S.Security_Name),
        [Broker] = MIN(TCA.[Broker]),
        Country = MIN(TCA.COUNTRY),
        TotalValue = SUM(TCA.TOTAL_VALUE),
        Performance = MIN( (CASE WHEN TCA.COUNTRY = 'US' THEN TCA.B2NetPctCst ELSE TCA.B1NetPctCst END) ),
        TCAException = MIN(tvf.Message),
        Benchmark = MIN(tvf.Benchmark),
		ReasonCode = MIN(rc.Description),
		ReasonCodeDescriptive = MIN(rc.Narrative),
		AsAtDate = MAX(tca.CADIS_SYSTEM_UPDATED),
		AsOfDate = MAX(tca.CADIS_SYSTEM_INSERTED)

    FROM 
        [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] tca
    LEFT OUTER JOIN   dbo.T_MASTER_SEC   S 
		ON tca.Symbol = S.ISIN
	LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
		ON tca.ReasonCode = rc.Description
	CROSS APPLY dbo.ufn_DetectTCAException(tca.Country,tca.B1NETPCTCST, tca.B2NETPCTCST, DEFAULT) AS tvf
	WHERE
		rc.Code IN (1,2,3,4,5,6,8)
    GROUP BY 
        year(tca.Trade_Date_time),
        month(tca.Trade_Date_time),
        TCA.OrderId

	UNION ALL

	-- we need to treat risk trades differently

	 SELECT  
        [Year] = YEAR(tca.Trade_Date_time),
        [Month] = MONTH(tca.Trade_Date_time),
        TCA.OrderId,
        Security_Name = MIN(S.Security_Name),
        [Broker] = MIN(TCA.[Broker]),
        Country = MIN(TCA.COUNTRY),
        TotalValue = SUM(TCA.TOTAL_VALUE),
        Performance = MIN( (CASE WHEN TCA.COUNTRY = 'US' THEN TCA.B2NetPctCst ELSE TCA.B1NetPctCst END) ),
        TCAException = MIN(tvf.Message),
        Benchmark = MIN(tvf.Benchmark),
		ReasonCode = MIN(rc.Description),
		ReasonCodeDescriptive = MIN(rc.Narrative),
		AsAtDate = MAX(TCA.CADIS_SYSTEM_UPDATED),
		AsOfDate = MAX(TCA.CADIS_SYSTEM_INSERTED)
    FROM 
        [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_deaggregated]    TCA
    INNER JOIN
        (
        select distinct I_TSORDNUM, C_IDENTIFIER, C_REASONCODE, C_BROKER, f_price from [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT]
        ) A ON TCA.OrderId = A.I_TSORDNUM 
		AND TCA.Broker = A.C_BROKER
		AND TCA.ORIG_PRICE = A.F_PRICE
		and a.C_reasoncode = 7
    LEFT OUTER JOIN   dbo.T_MASTER_SEC   S 
		ON tca.Symbol = S.ISIN
	LEFT OUTER JOIN dbo.T_BBG_ReasonCode rc
		ON tca.ReasonCode = rc.Description
	CROSS APPLY dbo.ufn_DetectTCAException(tca.Country,tca.B1NETPCTCST, tca.B2NETPCTCST, DEFAULT) AS tvf
	WHERE
		rc.Code = 7
    GROUP BY 
        year(tca.Trade_Date_time),
        month(tca.Trade_Date_time),
        TCA.OrderId
) X
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
FROM CTE t1 ) innerquery) y
on X.ORDERID = y.OrderId

WHERE X.Year = YEAR(DATEADD(month, DATEDIFF(month, -1, getdate()) - 2, 0))
and X.Month = MONTH(DATEADD(month, DATEDIFF(month, -1, getdate()) - 2, 0))


