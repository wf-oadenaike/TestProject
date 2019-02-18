
CREATE VIEW [Access.WebDev].[AggregationPolicyVolumeDifference]
/******************************
** Desc: Aggregation Policy - Utilitised by the Reporting team via EDM data generators 
		 / functions to display Volume tolerance violations
** Auth: R. Walker
** Date: 07/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1742     07/02/2018  R.Walker	Initial version of view
*******************************/
AS
-- Where the orders have had a child order aggregated into them
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
		SELECT DISTINCT  -- to remove multiple rows per order 
				scp.OrderId, 
				scp.Child_Order_Id, 
				scp.ORDERSHARES,
				scp.SECURITY_NAME,
				scp.TICKER,
				DATEPART(yy, scp.Decision_Date_Time) AS [Year],
				DATEPART(mm, scp.Decision_Date_Time) AS [Month]
		FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] scp
		INNER JOIN CTE_DEAGG deagg ON scp.OrderID = deagg.OrderId 
	)
 
SELECT  ord.OrderId, 
		ord.SECURITY_NAME AS SecurityName,
		ord.Ticker,
		ord.Child_Order_Id AS ChildOrderId, 
		ord.Ordershares AS OrderIdOrderShares, 
		alt.OrderId AS ConstituentOrderId, 
		alt.ORDERSHARES AS ConstituentOrderIdOrdershares, 
		(ord.ORDERSHARES / alt.ORDERSHARES) * 100 AS PercentofConstituentOrdertoOrder,
		ord.[Year],
		ord.[Month],
		cmt.Concatenated AS SlackCommentary
FROM CTE_Scope ord
INNER JOIN CTE_Scope alt
ON ord.Child_Order_Id = alt.Child_Order_Id
	AND ord.OrderId <> alt.OrderId
LEFT OUTER JOIN
(SELECT innerquery.OrderId, 
		innerquery.Concatenated 
 FROM
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
ON ord.OrderId = cmt.OrderId



