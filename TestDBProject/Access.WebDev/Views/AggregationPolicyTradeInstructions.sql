
CREATE VIEW [Access.WebDev].[AggregationPolicyTradeInstructions]
/******************************
** Desc: Aggregation Policy - Utilitised by the Reporting team via EDM data generators 
		 / functions to display aggregated trade instructions violations
** Auth: R. Walker
** Date: 08/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1744     08/02/2018  R.Walker	Initial version of view
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
				Child_Order_Id, 
				ORDERSHARES,
				SECURITY_NAME,
				TICKER,
				DATEPART(yy, Decision_Date_Time) AS [Year],
				DATEPART(mm, Decision_Date_Time) AS [Month]
		FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] scp
		INNER JOIN CTE_DEAGG deagg ON scp.OrderID = deagg.OrderId 
	)

SELECT DISTINCT 
	scp.OrderId,
	scp.Child_Order_Id AS ChildOrderId,
	scp.SECURITY_NAME AS SecurityName, 
	scp.Ticker,
	scp.OrderShares, 
	cd.Narrative AS ReasonCode,
	scp.[Year],
	scp.[Month],
	cmt.Concatenated AS SlackCommentary, 
	cnt.CountOfRCPerChildOrder 
FROM CTE_Scope scp
INNER JOIN 
		(
			SELECT Child_Order_Id, 
					COUNT(DISTINCT ISNULL(REASONCODE,'NULL')) AS CountOfRCPerChildOrder 
			FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] 
			GROUP BY Child_Order_Id
		) cnt ON scp.Child_Order_Id = cnt.Child_Order_Id 
INNER JOIN [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] rc ON scp.OrderId = rc.OrderID 
	AND scp.Child_Order_Id = rc.Child_Order_Id
LEFT OUTER JOIN dbo.T_BBG_REASONCODE cd ON rc.REASONCODE = cd.[Description]
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
WHERE cnt.CountOfRCPerChildOrder > 1



