
CREATE VIEW [Access.WebDev].[FailedTradesByBrokerVw]
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
** DAP-2319     17/10/2018  R.Walker	Remnove C_EVENT "POSTTRAD ALLOC CXL/COR" to prevent duplication
** DAP-2397     06/11/2018  R.Walker	Drive data from ASD instead of TradeDate and restrict data to where there is a valid ASD only
******************************/
AS

WITH NTFailedTradebyYearMonthBroker
     AS (
          SELECT DATEPART(YEAR, f.ASD)  AS TRADE_YEAR,
                 DATEPART(MONTH, f.ASD) AS TRADE_MONTH,
                 b.C_BROKER,
                 COUNT(f.IM_REFERENCE)         AS FailTradeCount,
                 SUM(f.NET_MONEY)              AS MonthlyTotal,
				 MAX(F.CADIS_SYSTEM_UPDATED)	   aS LastUpdatedDate
          FROM T_NT_Failed_Trade_Report F
          LEFT OUTER JOIN [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] B WITH (NOLOCK)
               ON F.IM_REFERENCE = b.I_TKTNUM
               AND B.C_EVENT IN ('ORDER ALLOCATED', 'CORRECTED ALLOCATION')
          WHERE DATEPART(YEAR, F.ASD) >= 2017 AND b.C_BROKER NOT IN ('SPLIT', 'MISHCON', 'DIRECT')
          GROUP BY DATEPART(YEAR, F.ASD),
                   DATEPART(MONTH, F.ASD),
                   b.C_BROKER
     ),
     BloombergTradebyYearMonthBroker
     AS (
          SELECT DATEPART(YEAR, ISNULL(ASD, D_SETTLEDT))  AS TRADE_YEAR,
                 DATEPART(MONTH, ISNULL(ASD,D_SETTLEDT)) AS TRADE_MONTH,
                 C_BROKER,
                 COUNT(1)                AS TradeCount
          FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] B WITH (NOLOCK)
		  LEFT OUTER JOIN T_NT_Failed_Trade_Report F
				ON F.IM_REFERENCE = b.I_TKTNUM
          WHERE B.C_EVENT IN ('ORDER ALLOCATED', 'CORRECTED ALLOCATION')
          AND DATEPART(YEAR, D_SETTLEDT) >= 2017 AND b.C_BROKER NOT IN ('SPLIT', 'MISHCON', 'DIRECT')
          GROUP BY DATEPART(YEAR, ISNULL(ASD, D_SETTLEDT)),
                   DATEPART(MONTH, ISNULL(ASD,D_SETTLEDT)),
                   b.C_BROKER
     ),
     BloombergTradebyYearMonth
     AS (
		  SELECT TRADE_YEAR,
                 TRADE_MONTH,
				 SUM(TradeCount)                AS TradeCount
		  FROM BloombergTradebyYearMonthBroker
		  GROUP BY TRADE_YEAR,
                 TRADE_MONTH
     ),
	 RAG
	 AS (
			SELECT TradeYearMonth, BrokerUniqueRef, 'Category Count - RED: ' + CAST([RED] AS VARCHAR) + ' AMBER: ' + CAST([AMBER] AS VARCHAR)  + ' GREEN: ' + CAST([GREEN] AS VARCHAR)  AS CategoryCount FROM
			(SELECT TradeYearMonth, BrokerUniqueRef, RAG FROM [Access.WebDev].[FailedTradesByBrokerDetailVw]) src
			PIVOT
			(
				COUNT(RAG)
				FOR RAG IN
			( [RED], [AMBER], [GREEN])
			) AS pvt
		)
SELECT T.TRADE_YEAR                                                       AS TradeYear,
       T.TRADE_MONTH                                                      AS TradeMonth,
	   cast(T.TRADE_YEAR as varchar) + '_' + cast(T.TRADE_MONTH as varchar)	 as TradeYearMonth,  
	   B.BROKER															  AS BrokerUniqueRef,
       B.Broker_Short_Name												  AS Broker,
       T.TradeCount                                                       AS TradeCount,
       ISNULL(F.FailTradeCount, 0)                                        AS FailTradeCount,
       CAST(ISNULL(F.FailTradeCount, 0) AS decimal(10, 2)) / T.TradeCount AS PercentageShare,
       CAST(ISNULL(F.FailTradeCount, 0) AS decimal(10, 2)) / M.TradeCount AS PercentageShareTotal,
       CASE
            WHEN F.FailTradeCount IS NULL THEN 0
            ELSE f.MonthlyTotal
       END                                                                AS MonthlyTotal,
	   F.LastUpdatedDate												  as LastUpdatedDate,
	   rag.CategoryCount
FROM BloombergTradebyYearMonthBroker T
INNER JOIN BloombergTradebyYearMonth M
     ON T.TRADE_YEAR = M.TRADE_YEAR
     AND T.TRADE_MONTH = M.TRADE_MONTH
INNER JOIN dbo.T_BBG_BROKER	B
	 ON T.C_BROKER = B.Broker
LEFT OUTER JOIN NTFailedTradebyYearMonthBroker F
     ON T.TRADE_YEAR = F.TRADE_YEAR
     AND T.TRADE_MONTH = F.TRADE_MONTH
     AND T.C_BROKER = F.C_BROKER
LEFT OUTER JOIN RAG rag
     ON cast(T.TRADE_YEAR as varchar) + '_' + cast(T.TRADE_MONTH as varchar) = rag.TradeYearMonth
     AND B.BROKER = rag.BrokerUniqueRef




