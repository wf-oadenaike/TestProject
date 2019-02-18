

CREATE VIEW [Access.WebDev].[BERCMonthlyOrderValueSummaryByCountryVw]
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
** DAP-1764		06/02/1018	W.Stubbs	Point at deagg data
** DAP-2325	04/10/2018 OLU Add AsAtDate and AsOfDate
*******************************/
select 
	 tca.Year																AS [Year]
	,tca.Month																AS [Month]
	,tca.Country															AS [Country]
	,trc.CTY_NAME															AS [CountryName]
	,tca.TotalValue
	,AsOfDate
	,AsAtDate
from
(
	(select 
		 YEAR(Trade_Date_time)												AS [Year]
		,MONTH(Trade_Date_time)												AS [Month]
		,Country															AS [Country]
		,SUM(Total_value)													AS [TotalValue]
		,MAX(Trade_Date_time)												AS [AsOfDate]
		,MAX(CADIS_SYSTEM_UPDATED)											AS [AsAtDate]
	from
	[dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED]
	group by 
		year(Trade_Date_time),
		month(Trade_Date_time),
		Country) TCA
inner join
	[dbo].[T_REF_COUNTRY] trc on tca.country = trc.[ISO_CTY_CD])


