
CREATE VIEW [Reporting].[vw_MasterPosition]
/******************************
** Desc: Reporting view over Master Position
**		 
** Auth: R. Walker
** Date: 14/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1785     14/02/2018  R.Walker	Initial version of view
*******************************/
AS 


SELECT pos.[POSITION_DATE]
      ,pos.[FUND_SHORT_NAME]
      ,pos.[EDM_SEC_ID]
	  ,prc.[SECURITY_NAME]
      ,pos.[POSITION_TYPE]
      ,pos.[LONG_SHORT_IND]
      ,pos.[SOURCE]
      ,pos.[QUANTITY]
	  ,prc.[PRICE_TYPE]
	  ,pos.[QUANTITY] * prc.[MASTER_PRICE] AS [VALUE]
	  ,pos.[QUANTITY] * prc.[MASTER_PRICE] / val.TOTAL_MARKET_VALUE_BASE AS [WEIGHTING]
	  ,pos.[CADIS_SYSTEM_INSERTED]
      ,pos.[CADIS_SYSTEM_UPDATED]
      ,pos.[CADIS_SYSTEM_CHANGEDBY]
      ,pos.[CADIS_SYSTEM_PRIORITY]
      ,pos.[CADIS_SYSTEM_LASTMODIFIED]
FROM [dbo].[T_MASTER_POS] pos
INNER JOIN [Reporting].[vw_MasterPrice] prc
ON pos.EDM_SEC_ID = prc.EDM_SEC_ID
	AND pos.[POSITION_DATE] = prc.[PRICE_DATE]
LEFT OUTER JOIN [dbo].[T_MASTER_FND_MARKET_VALUE] val
ON pos.[POSITION_DATE] = val.[POSITION_DATE]
	AND pos.[POSITION_TYPE] = val.[POSITION_TYPE]
	AND pos.[FUND_SHORT_NAME] = val.[FUND_SHORT_NAME]
WHERE PRICE_TYPE = 'EOD'



