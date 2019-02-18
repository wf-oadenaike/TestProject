
--Use vw to Create views 
CREATE VIEW [Sisense].[vw_BusinessUnit_MasterPrice]
/******************************
** Desc: Reporting view over Master Price calculating Pricing columns based on GBP / GBp   
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

SELECT 
	pc.EDM_SEC_ID, 
	sc.SECURITY_NAME, 
	pc.TICKER,
	PRICE_TYPE, 
	PRICE_SOURCE, 
	PRICE_DATE, 
	PRICE_TIME, 
	CASE WHEN PRICE_ISO_CCY COLLATE Latin1_General_CS_AS <> 'GBP' THEN CAST(AVERAGE_COST AS DECIMAL(24,10)) / 100 ELSE CAST(AVERAGE_COST AS DECIMAL(24,10)) END AS AVERAGE_COST, 
	PRICE_SOURCE_RANKING, 
	PRICE_ISO_CCY, 
	CASE WHEN PRICE_ISO_CCY COLLATE Latin1_General_CS_AS <> 'GBP' THEN  MASTER_PRICE / 100 ELSE MASTER_PRICE END AS MASTER_PRICE, 
	CASE WHEN PRICE_ISO_CCY COLLATE Latin1_General_CS_AS <> 'GBP' THEN  ASK_PRICE / 100 ELSE ASK_PRICE END AS ASK_PRICE, 
	CASE WHEN PRICE_ISO_CCY COLLATE Latin1_General_CS_AS <> 'GBP' THEN  MID_PRICE / 100 ELSE MID_PRICE END AS MID_PRICE, 
	CASE WHEN PRICE_ISO_CCY COLLATE Latin1_General_CS_AS <> 'GBP' THEN  BID_PRICE / 100 ELSE BID_PRICE END AS BID_PRICE, 
	LAST_UPDATE_DATE, 
	FX_RATE, 
	MARKET_VALUE, -- Is this in pounds or pence?
	pc.CADIS_SYSTEM_INSERTED, 
	pc.CADIS_SYSTEM_UPDATED, 
	pc.CADIS_SYSTEM_CHANGEDBY, 
	pc.CADIS_SYSTEM_PRIORITY, 
	pc.CADIS_SYSTEM_TIMESTAMP, 
	pc.CADIS_SYSTEM_LASTMODIFIED
FROM dbo.T_MASTER_PRC pc
INNER JOIN dbo.T_MASTER_SEC sc
ON pc.EDM_SEC_ID = sc.EDM_SEC_ID

