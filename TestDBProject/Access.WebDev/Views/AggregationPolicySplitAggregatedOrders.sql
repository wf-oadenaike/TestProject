
CREATE VIEW [Access.WebDev].[AggregationPolicySplitAggregatedOrders]
/******************************
** Desc: Aggregation Policy - Utilitised by the Reporting team via EDM data generators 
		 / functions to display aggregated orders that were further split
** Auth: R. Walker
** Date: 14/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1796     14/02/2018  R.Walker	Initial version of view
*******************************/
AS 

SELECT	C_LINKFROM AS OrderIdFrom, 
		C_LINKTO AS OrderIdTo, 
		C_EVENT AS [Event], 
		I_TSORDNUM AS OrderId, 
		C_ACCOUNT AS Account, 
		C_SECURITY AS [Security], 
		C_TICKER AS Ticker, 
		F_QUANTITY AS Quantity, 
		F_PRICE AS Price, 
		C_BROKER AS [Broker],
		cmt.Concatenated AS SlackCommentary,
		DATEPART(yy, D_DATE) AS [Year],
		DATEPART(mm, D_DATE) AS [Month]		 
FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] adt 
LEFT OUTER JOIN
(SELECT innerquery.OrderId, innerquery.Concatenated FROM
	(SELECT DISTINCT
			I_TSORDNUM AS OrderId,
			STUFF((
				SELECT ';'+ISNULL(Narrative,'')
				FROM [TCA].[TCANarrativeEvents] t2
				WHERE t2.OrderID = t1.I_TSORDNUM
				ORDER BY eventdate ASC
				FOR XML PATH('')
	 ), 1,1,'') Concatenated
FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] t1 ) innerquery) cmt
ON adt.I_TSORDNUM = cmt.OrderId
WHERE C_EVENT IN ('DEAGGREGATED FROM', 'SPLIT ACCOUNT(S) FROM ORDER', 'SPLIT ORDER')
	AND D_DATE < CONVERT(VARCHAR(6), GETDATE(), 112) + '01' -- restrict to rolling 12 months from end of last complete month 
	AND D_DATE >= DATEADD(yy, -1, (CONVERT(VARCHAR(6), GETDATE(), 112) + '01'))



