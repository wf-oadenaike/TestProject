

CREATE VIEW [Access.WebDev].[FailedTradesVw]
/******************************
** Desc: Failed Trades - Used "WebDev BERC Failed Trades By Broker Detail" DG
** Auth: V.Khatri
** Date: 07/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** ??			07/2018		V.Khatri	Initial version of view
** DAP-2302     21/09/2018  R.Walker	Add RAG processing for delayed settlements
** DAP-2397     06/11/2018  R.Walker	Drive data from ASD instead of TradeDate and restrict data to where there is a valid ASD only
******************************/
AS
WITH RAG
	 AS (
			SELECT TradeYearMonth, 'Category Count - RED: ' + CAST([RED] AS VARCHAR) + ' AMBER: ' + CAST([AMBER] AS VARCHAR)  + ' GREEN: ' + CAST([GREEN] AS VARCHAR)  AS CategoryCount FROM
			(SELECT TradeYearMonth, RAG FROM [Access.WebDev].[FailedTradesByBrokerDetailVw]) src
			PIVOT
			(
				COUNT(RAG)
				FOR RAG IN
			( [RED], [AMBER], [GREEN])
			) AS pvt
		)
select	TradeYear, 
		TradeMonth, 
		brk.TradeYearMonth															as TradeYearMonth,
		SUM(TradeCount)																as TradeCount,
		SUM(FailTradeCount)															as FailTradeCount,
		SUM(PercentageShareTotal)													as PercentageShareTotal,
		SUM(MonthlyTotal)															as MonthlyTotal,
		max(LastUpdatedDate)														as LastUpdatedDate,
		rag.CategoryCount
from  [Access.WebDev].[FailedTradesByBrokerVw] brk
LEFT OUTER JOIN RAG rag
ON brk.TradeYearMonth = rag.TradeYearMonth
group by TradeYear, TradeMonth, brk.TradeYearMonth, rag.CategoryCount




