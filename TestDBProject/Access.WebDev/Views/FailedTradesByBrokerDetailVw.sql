CREATE VIEW [Access.WebDev].[FailedTradesByBrokerDetailVw]
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
** DAP-2302     07/09/2018  R.Walker	Add RAG processing for delayed settlements
** DAP-2319     17/10/2018  R.Walker	Remnove C_EVENT "POSTTRAD ALLOC CXL/COR" to prevent duplication
** DAP-2397     06/11/2018  R.Walker	Drive data from ASD instead of TradeDate and restrict data to where there is a valid ASD only
******************************/
AS

WITH CTE_RAG AS (SELECT 4 AS tolerance, '1-4 days' AS Category, 'GREEN' AS colour
					UNION
				 SELECT 10 AS tolerance, '5-10 days' AS Category, 'AMBER' AS colour
				 	UNION
				 SELECT 10000 AS tolerance, 'more than 10 days' AS Category,  'RED' AS colour
				 )	
select  DATEPART(YEAR, t.ASD)	as TradeYear, 
		DATEPART(MONTH, t.ASD)	as TradeMonth, 
		cast(DATEPART(YEAR, t.ASD) as varchar) + '_' + cast(DATEPART(MONTH, t.ASD) as varchar)	as TradeYearMonth,
	    BR.BROKER						 AS BrokerUniqueRef,
        BR.Broker_Short_Name			 AS Broker,
		t.Isin,
		t.SECURITY_NAME					as Security,
		t.TRADE_DATE					as TradeDate,
		t.SIDE							as Side,
		t.ASSET_TYPE					as AssetType,
		t.NET_MONEY						as NetMoney,
		t.SETTLEMENT_CURR				as Currency,
		t.INTERNAL_NOTES				as Comment1,
		t.INTERNAL_NOTES_HISTORY		as Comment2,
		t.CADIS_SYSTEM_UPDATED			as LastUpdatedDate,
		t.Settlement_Date,
		t.ASD AS ASD,
		DATEDIFF(dd, t.SETTLEMENT_DATE, t.ASD) AS Days_delayed,
		(SELECT TOP 1 Category FROM CTE_RAG WHERE tolerance >=DATEDIFF(dd, t.SETTLEMENT_DATE, t.ASD) ORDER BY tolerance ASC) AS Category,
		(SELECT TOP 1 colour FROM CTE_RAG WHERE tolerance >= DATEDIFF(dd, t.SETTLEMENT_DATE, t.ASD) ORDER BY tolerance ASC) AS RAG -- greater than 10 will be defaulted to RED
FROM T_NT_Failed_Trade_Report t
LEFT OUTER JOIN [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] B WITH (NOLOCK)
    ON t.IM_REFERENCE = b.I_TKTNUM
    AND B.C_EVENT IN ('ORDER ALLOCATED', 'CORRECTED ALLOCATION')
INNER JOIN dbo.T_BBG_BROKER	BR
	 ON B.C_BROKER = BR.Broker
WHERE DATEPART(YEAR, t.ASD) >= 2017 AND BR.BROKER NOT IN ('SPLIT', 'MISHCON', 'DIRECT') 
	AND t.ASD IS NOT NULL



