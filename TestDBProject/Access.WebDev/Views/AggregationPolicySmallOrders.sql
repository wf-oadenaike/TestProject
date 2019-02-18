
CREATE VIEW [Access.WebDev].[AggregationPolicySmallOrders]
/******************************
** Desc: Aggregation Policy - Utilitised by the Reporting team via EDM data generators 
		 / functions to display small order violations
** Auth: R. Walker
** Date: 08/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1747     08/02/2018  R.Walker	Initial version of view
*******************************/
AS

SELECT DISTINCT 
		agg.OrderID, 
		agg.Security_Name AS SecurityName, 
		agg.Ticker, 
		agg.OrderShares, 
		agg.TOTAL_VALUE AS TotalValue,
		DATEPART(yy, agg.Decision_Date_Time) AS [Year],
		DATEPART(mm, agg.Decision_Date_Time) AS [Month],
		cmt.Concatenated AS SlackCommentary 
FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] agg
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
FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] t1 ) innerquery) cmt
ON agg.OrderId = cmt.OrderId
WHERE Decision_Date_Time < CONVERT(VARCHAR(6), GETDATE(), 112) + '01' -- restrict to rolling 12 months from end of last complete month 
	AND Decision_Date_Time >= DATEADD(yy, -1, (CONVERT(VARCHAR(6), GETDATE(), 112) + '01'))




