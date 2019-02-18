
CREATE VIEW [reporting].[MasterSecurity]
/******************************
** Desc: Reporting view over Master Security
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

SELECT [EDM_SEC_ID]
      ,[SECURITY_NAME]
      ,[SECURITY_DESCRIPTION]
      ,[SECURITY_SHORTNAME]
      ,[ASSET_TYPE]
      ,[SECURITY_TYPE]
      ,[CUSIP]
      ,[ISIN]
      ,[SEDOL]
      ,[TICKER]
      ,[VALOREN]
      ,[WERTPAPIER]
      ,[SECURITY_ISO_CCY]
      ,[RISK_ISO_CCY]
      ,[FIXED_ISO_CCY]
      ,[INCORPORATION_ISO_CTY]
      ,[DOMICILE_ISO_CTY]
      ,[ISSUE_COUNTRY_ISO]
      ,[RISK_ISO_CTY]
      ,[MIC_EXCHANGE_CODE]
      ,[BBG_EXCHANGE_CODE]
      ,[STATE_CODE]
      ,[ACTIVE_TRADE_INDICATOR]
      ,[144A_INDICATOR]
      ,[PRIVATE_PLACEMENT_INDICATOR]
      ,[ILLIQUID]
      ,[QUOTE_TYPE]
      ,[DAYS_TO_SETTLE]
      ,[TRADE_SETTLEMENT_CALENDAR_CODE]
      ,[CADIS_SYSTEM_UPDATED]
      ,[UNIQUE_BLOOMBERG_ID]
      ,[BBG_SECTOR]
      ,[BBG_SUBSECTOR]
      ,[BBG_GROUP]
      ,[IS_IPO]
      ,[PARSEKEYABLE_DESCRIPTION]
      ,[SECURITY_IDENTIFIER]
      ,[IRISH_SEDOL_NUMBER]
      ,[ISSUER]
      ,[CUR_MAR_CAP]
      ,[PRIMARY_EXCHANGE_NAME]
      ,[SECURITY_HAS_ADRS]
      ,[WITHHOLDING_TAX]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [dbo].[T_MASTER_SEC]



