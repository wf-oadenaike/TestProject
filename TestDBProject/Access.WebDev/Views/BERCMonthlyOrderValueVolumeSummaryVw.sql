

CREATE VIEW [Access.WebDev].[BERCMonthlyOrderValueVolumeSummaryVw]
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
** DAP-1764		06/02/2018	W.Stubbs	Point at deagg data
** DAP-2325		04/10/2018  olu			Add AsAtDate and AsOfDate
*******************************/
select 
	YEAR(tca.Trade_Date_time)												AS [Year]
	,MONTH(tca.Trade_Date_time)												AS [Month]
	,SUM(tca.Total_value)													AS [TotalValue]
	,COUNT(DISTINCT tca.OrderId)											AS [NumberOfOrders]
	,MAX(CADIS_SYSTEM_UPDATED)												AS [AsAtDate]
	,MAX(CADIS_SYSTEM_INSERTED)												AS [AsOfDate]
from 
	[dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] TCA
group by 
	 year(tca.Trade_Date_time)
	,month(tca.Trade_Date_time)


