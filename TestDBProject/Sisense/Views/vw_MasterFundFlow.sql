
CREATE VIEW [Sisense].[vw_MasterFundFlow]
/******************************
** Desc: Reporting view over Master Fund Flow
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
SELECT [FUND_SHORT_NAME]
      ,[TRANSACTION_DATE]
      ,[CURRENCY]
      ,[FUND_FLOW_TYPE]
      ,[FLOW_TYPE]
      ,[SOURCE_TYPE]
      ,[MARKET_VALUE]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_LASTMODIFIED]
      ,[SOURCE]
      ,[DATA_SOURCE]
  FROM [dbo].[T_MASTER_FUND_FLOW]



