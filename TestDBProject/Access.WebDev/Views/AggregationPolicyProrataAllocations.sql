
CREATE VIEW [Access.WebDev].[AggregationPolicyProrataAllocations]
/******************************
** Desc: Aggregation Policy - Utilitised by the Reporting team via EDM data generators 
		 / functions to display pro-rata allocation violations
** Auth: R. Walker
** Date: 08/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1746     08/02/2018  R.Walker	Initial version of view
*******************************/
AS 

WITH CTE_DEAGG AS 
	(
		SELECT DISTINCT	OrderId
		FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] 
		WHERE Decision_Date_Time < CONVERT(VARCHAR(6), GETDATE(), 112) + '01' -- restrict to rolling 12 months from end of last complete month 
			AND Decision_Date_Time >= DATEADD(yy, -1, (CONVERT(VARCHAR(6), GETDATE(), 112) + '01'))
			AND OrderID <> Child_Order_Id
	)
	,CTE_Scope AS 
	(
		SELECT 	scp.OrderId, 
				SECURITY_NAME,
				TICKER, 
				ACCOUNT,  
				SUM(TRADE_SHARES) AS SUM_OF_TRADE_SHARES,
				DATEPART(yy, Decision_Date_Time) AS [Year],
				DATEPART(mm, Decision_Date_Time) AS [Month]
		FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] scp
		INNER JOIN CTE_DEAGG deagg ON scp.OrderId = deagg.OrderId
		WHERE Decision_Date_Time < CONVERT(VARCHAR(6), GETDATE(), 112) + '01' -- restrict to rolling 12 months from end of last complete month 
			AND Decision_Date_Time >= DATEADD(yy, -1, (CONVERT(VARCHAR(6), GETDATE(), 112) + '01'))
		GROUP BY
				scp.OrderId, 
				SECURITY_NAME,
				TICKER,
				ACCOUNT,
				DATEPART(yy, Decision_Date_Time),
				DATEPART(mm, Decision_Date_Time)
	)

SELECT	scp.OrderID, 
		scp.SECURITY_NAME AS SecurityName, 
		scp.Ticker,
		scp.Account, 
		scp.SUM_OF_TRADE_SHARES AS SumOfTradeShares, 
		adt.F_QUANTITY AS FQuantity, 
		SUM(adt.F_QUANTITY) OVER (PARTITION BY scp.OrderID, scp.[ACCOUNT]) AS TotalFQuantity,
		scp.[Year],
		scp.[Month],
		cmt.Concatenated AS SlackCommentary
FROM CTE_Scope scp
LEFT OUTER JOIN [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] adt ON scp.OrderId = adt.I_TSORDNUM 
	AND scp.ACCOUNT= adt.C_ACCOUNT 
	ANd adt.C_EVENT = 'Activated Order'
LEFT OUTER JOIN
(SELECT innerquery.OrderId, innerquery.Concatenated FROM
	(SELECT DISTINCT
			OrderID,
			STUFF((
				SELECT ';'+ISNULL(Narrative,'')
				FROM [TCA].[TCANarrativeEvents] t2
				WHERE t2.OrderID = t1.OrderID
				ORDER BY eventdate ASC
				FOR XML PATH('')
	 ), 1,1,'') Concatenated
FROM CTE_Scope t1 ) innerquery) cmt
ON scp.OrderId = cmt.OrderId



