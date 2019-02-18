
CREATE VIEW [Sisense].[vw_MasterSecEquity]
/******************************
** Desc: Reporting view over Master Security Equity
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

SELECT [EDM_SEC_ID]
      ,[EX_DIVIDEND_DATE]
      ,[DIVIDEND_FREQUENCY]
      ,[DIVIDEND_PAY_DATE]
      ,[DIVIDEND_PER_SHARE_LAST_NET]
      ,[DIVIDEND_PER_SHARE_LAST_GROSS]
      ,[DIVIDEND_PER_SHARE_ANNUAL_GROSS]
      ,[DIVIDEND_TYPE]
      ,[DIVIDEND_RECORD_DATE]
      ,[CURRENT_STOCK_DIVIDEND_EX_DATE]
      ,[CURRENT_STOCK_DIVIDEND_PAY_DATE]
      ,[CURRENT_STOCK_DIVIDEND_PCT]
      ,[NORMAL_MARKET_SIZE]
      ,[SHARES_OUTSTANDING]
      ,[SHARES_OUTSTANDING_DATE]
      ,[IPO]
      ,[VOL_WEIGHTED_AVERAGE_PRICE]
      ,[FUND_NET_ASSET_VALUE]
      ,[FUND_TOTAL_ASSETS]
      ,[LAST_UPDATE_DATE_EXCHANGE_TIMEZONE]
      ,[TOTAL_VOTING_SHARES]
      ,[SHARE_OUTSTANDING_REAL_ACTUAL]
      ,[TOTAL_VOTING_SHARES_VALUE]
      ,[LAST_PUBLISHED_OFFER_NO_OF_SHARES]
      ,[SHARE_OUTSTANDING_REAL_VALUE]
      ,[CURRENT_MARKET_CAP]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_LASTMODIFIED]
      ,[EQUITY_UNDERLYING_TICKER]
      ,[DIVIDEND_CCY]
  FROM [dbo].[T_MASTER_SEC_EQUITY]



