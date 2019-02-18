

CREATE VIEW [Access.WebDev].[BERCMonthlyOrderValueSummaryBySecurityVw]
AS
/******************************
** Desc:
** Auth: D.Fanning
** Date: 30/10/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1405     30/10/2017  D.Fanning   Initial version of view
** OSPREY-1671	12/01/2018	W.Stubbs	Add calculated column of percentage of stock trades of total trades
** OSPREY-1902	19/01/2018	W.Stubbs	Restrict to last 12 months
** OSPREY-1656	19/01/2018	W.Stubbs	Add buy/Sell indicators
** OSPREY-1984	02/02/2018	W.Stubbs	Change to date filter
** DAP-1764		06/02/2018	W.Stubbs	Point to deagg data	
** DAP-2325	04/10/2018 OLU Add AsAtDate and AsOfDate
*******************************/
WITH TotalValueCTE AS
(
SELECT
	YEAR(tca.Trade_Date_time)												AS 'Year',
	MONTH(tca.Trade_Date_time)												AS 'Month',
	SUM(tca.Total_value)													AS 'TotalValue'
	FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] TCA
	GROUP BY 
		YEAR(TCA.Trade_Date_time),
		MONTH(TCA.Trade_Date_time)
)

SELECT
	X.Year																	AS 'Year',
	X.Month																	AS 'Month',
	X.Security_Name															AS 'Security_Name',
	X.TotalValue															AS 'TotalValue',
	X.NumberOfOrders														AS 'NumberOfOrders',
	X.BuySellFlag															AS 'BuySellFlag',
	X.Idx																	AS 'Idx',
	(X.TotalValue / ISNULL(NULLIF(TotalValueCTE.TotalValue,0),1) * 100)		AS 'TotalTradePct',
	X.AsAtDate																AS 'AsAtDate',
	X.AsOfDate																AS 'AsOfDate'

FROM
(
	SELECT 
		YEAR(tca.Trade_Date_time)									AS 'Year',
		MONTH(tca.Trade_Date_time)									AS 'Month',
		Security_Name												AS 'Security_Name',
		SUM(TCA.Total_value)										AS 'TotalValue',
		COUNT(DISTINCT TCA.OrderId)									AS 'NumberOfOrders',
		CASE
			WHEN MIN(TCA.Side) = 'Sell' THEN 'S'
			WHEN MAX(TCA.Side) = 'Buy' THEN 'B'
			ELSE 'BS'
			END														As BuySellFlag,
		ROW_NUMBER() OVER (
			PARTITION BY 
				YEAR(TCA.Trade_Date_time), 
				MONTH(TCA.Trade_Date_time) 
			ORDER BY SUM(TCA.Total_value) DESC)						AS Idx,
		MAX(CADIS_SYSTEM_INSERTED)									AS AsAtDate,
		MAX(CADIS_SYSTEM_UPDATED)								     AS AsOfDate
	FROM [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] TCA
	GROUP BY 
		YEAR(TCA.Trade_Date_time),
		MONTH(TCA.Trade_Date_time),
		SECURITY_NAME
) X
LEFT JOIN TotalValueCTE
ON
X.Year = TotalValueCTE.Year
AND X.Month = TotalValueCTE.Month
where
	X.Idx <= 5
	and not (X.Year = YEAR(GetDate()) AND X.Month = MONTH(GetDate()))
		
	and (
		-- either year is one less than current and month is equal or greater
		(X.Year = YEAR(GETDATE()) -1 AND X.Month >= MONTH(GETDATE()))
		or
		-- or year is equal to current and month is less
		(X.Year = YEAR(GETDATE()) AND X.Month < MONTH(GETDATE()))
		)


