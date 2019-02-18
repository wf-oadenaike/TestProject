
CREATE VIEW [Sisense].[vw_MasterFundMarketValue]
/******************************
** Desc: Reporting view over Master Fund Market Value
**		 
** Auth: R. Walker
** Date: 05/03/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1785     05/03/2018  R.Walker	Initial version of view
*******************************/
AS 

SELECT [SOURCE]
      ,[POSITION_TYPE]
      ,[FUND_SHORT_NAME]
      ,[POSITION_DATE]
      ,[TOTAL_MARKET_VALUE_LOCAL]
      ,[TOTAL_MARKET_VALUE_BASE]
      ,[STATUS]
      ,[TOTAL_ACCRUED_MARKET_VALUE_BASE]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [dbo].[T_MASTER_FND_MARKET_VALUE]


