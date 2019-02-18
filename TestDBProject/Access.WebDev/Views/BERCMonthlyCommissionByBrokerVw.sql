


CREATE VIEW [Access.WebDev].[BERCMonthlyCommissionByBrokerVw] 

AS

/******************************
** Desc: Total Commission by Broker by Month
** Auth: W.Stubbs
** Date: 13/12/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** OSPREY-1555  13/12/2017  W.Stubbs	   Initial version of view
** OSPREY-2087  01/06/2018  R.Walker	   Rewrite to use ITG (BBG) Commission data. Also related to DAP-1943/1944 
** DAP-2144		29/06/2018	R.Walker	   Use T_BBG_BROKER instead of static T_BLOOMBERG_BROKERINFO	
** DAP-2325		04/10/2018  OLU			   Add AsAtDate and AsOfDate
*******************************/
SELECT	YYear AS [Year], 
		FORMAT(MMonth,'00') AS [Month], 
		[Broker], 
		SUM(Commission) AS TotalCommission, 
		SUM(TOTAL_VALUE) AS TotalNotionalValue, 
		ROUND(SUM(Commission) / SUM(TOTAL_VALUE), 6) AS BlendedCommissionRate,
		MIN(COUNTRY) AS Country,
	--	SUM(CountOfTrades) AS TotalTrades,
		CAST(CAST(YYear AS CHAR(4)) + CAST(FORMAT(MMonth,'00') AS CHAR(2)) AS INT) AS SortOrder,
		MAX(LastUpdatedDate) as AsAtDate,
		MAX(LastUpdatedDate) as AsOfDate
FROM
(	SELECT	CAST(CONVERT(VARCHAR(6), Trade_Date_Time, 112) AS INT) AS YearMonth,
			YEAR(Trade_Date_Time) AS YYear, 
			MONTH(Trade_Date_Time) AS MMonth, 
			COALESCE(bbi.Broker_Short_Name, deagg.[Broker]) AS [Broker], 
			CAST(TOTAL_COMMISSION_IN_BASE_CURRENCY AS DECIMAL(20,6)) AS Commission,
			CAST(TRADE_SHARES AS DECIMAL(20,6)) AS Shares,
			TOTAL_VALUE,
			COUNTRY,
			deagg.CADIS_SYSTEM_UPDATED AS LastUpdatedDate
--			1 AS CountOfTrades
	FROM dbo.T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED deagg
	LEFT OUTER JOIN dbo.T_BBG_BROKER BBI
	ON deagg.[Broker] = BBI.[Broker] 
	WHERE deagg.[Broker] IS NOT NULL ) a
GROUP BY YYear, 
		 MMonth, 
		 [Broker]





