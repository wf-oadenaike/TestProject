﻿
CREATE VIEW [TCA].[zzz_V_REC_BLOOMBERG_TCA_OUT2]
AS

/********************************************************
-- Name: [TCA].[V_REC_BLOOMBERG_TCA_OUT2]
-- Decription: Extract data for rec between Bloomberg and TCA out table.

** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
-- DAP-1858		14/03/2018  V.Khatri	Initial Version
-- 
********************************************************/

WITH 
BLOOMBERG_TRADE
AS
(
SELECT
  CAST(OMSORDERNUMBER AS INT)                                         AS ORDER_NUMBER,
  CAST(TRADEDATE AS DATETIME)                                         AS TRADE_DATE,
  TICKER + ' ' + SERIESEXCHANGECODE                                   AS TICKER,
  TRADERACCOUNTNAME                                                   AS ACCOUNT,
  CUSTOMERACCOUNTCOUNTERPARTY										  AS BROKER_ID,
  CASE
    WHEN BUYSELLCOVERSHORTFLAG = 'B' THEN 'BUY'
    WHEN BUYSELLCOVERSHORTFLAG = 'S' THEN 'SELL'
  END                                                                 AS BUY_SELL,
  CAST(TRADEAMOUNT AS DECIMAL(28, 6))                                 AS TOTAL_QUANTITY_TRADED,
  CAST(PRICE AS DECIMAL(28, 6))                                       AS PRICE,
  ISNULL(R.DESCRIPTION, '')                                           AS REASON_CODE,
  CAST(TRANSACTIONCOST1_COST AS DECIMAL(28, 6))                       AS BROKER_COMMISSION
FROM DBO.T_MASTER_BBAIM_TRADE T WITH (NOLOCK)
LEFT OUTER JOIN [DBO].[T_BBG_REASONCODE] R
  ON T.OMREASONCODE = R.CODE
WHERE TRADERACCOUNTNAME NOT IN ('BDSEIF', 'TEST', 'TEST1') -- IGNORE NON LIVE BROKERS
--AND TICKER NOT LIKE '.%'	-- IGNORE UNQUOTED TICKERS
AND CANCELDATE IS NULL		-- ONLY INTERESTED IN LIVE TRADES
AND OMSORDERNUMBER IN 
	(
		SELECT DISTINCT ORDERID FROM [TCA].[BETA_TCAOUTPUTRESULTS] T WITH (NOLOCK)
	)
),
BLOOMBERG_AGREEGATED_DATA
AS
(
SELECT	ORDER_NUMBER,
		TICKER,
		ACCOUNT,
		BROKER_ID,
		BUY_SELL,
		SUM(TOTAL_QUANTITY_TRADED)																			AS TOTAL_QUANTITY_TRADED,
		SUM(TOTAL_QUANTITY_TRADED * PRICE) / SUM(TOTAL_QUANTITY_TRADED)										AS PRICE,
		SUM(TOTAL_QUANTITY_TRADED) * (SUM(TOTAL_QUANTITY_TRADED * PRICE) / SUM(TOTAL_QUANTITY_TRADED))		AS TOTAL_MARKET_VALUE,
		MAX(REASON_CODE)																					AS REASON_CODE,
		SUM(BROKER_COMMISSION)																				AS BROKER_COMMISSION
FROM BLOOMBERG_TRADE
GROUP BY ORDER_NUMBER,
		TICKER,
		ACCOUNT,
		BROKER_ID,
		BUY_SELL
),
TCA_TRADE
AS
(
SELECT
  CAST(ORDERID AS INT)                                           AS ORDER_NUMBER,
  C_SECURITY                                                     AS TICKER,
  ACCOUNT,
  BROKERID														 AS BROKER_ID,
  SIDE                                                           AS BUY_SELL,
  CAST(SHARES AS DECIMAL(28, 6))                                 AS TOTAL_QUANTITY_TRADED,
  CAST(PRICE AS DECIMAL(28, 6))                                  AS PRICE,
  CAST(SHARES AS DECIMAL(28, 6)) * CAST(PRICE AS DECIMAL(28, 6)) AS TOTAL_MARKET_VALUE,
  ISNULL(REASONCODE, '')                                         AS REASON_CODE,
  CAST(BROKERCOMMISSION AS DECIMAL(28, 6))                       AS BROKER_COMMISSION
FROM [TCA].[BETA_TCAOUTPUTRESULTS] T WITH (NOLOCK)
WHERE PRICE != ''
)
-- AS EXCEPT EXCLUDES DUPLICATES WE HAVE TO APPLY AN EXISTS AS WELL AS AN EXCEPT.
SELECT		'BLOOMBERG' AS DATA,
			ORDER_NUMBER,
			TICKER,
			ACCOUNT,
			BROKER_ID,
			BUY_SELL,
			TOTAL_QUANTITY_TRADED,
			PRICE,
			TOTAL_MARKET_VALUE,
			REASON_CODE,
			BROKER_COMMISSION
FROM BLOOMBERG_AGREEGATED_DATA T1
WHERE EXISTS
(
	SELECT  T1.ORDER_NUMBER,
			T1.TICKER,
			T1.ACCOUNT,
			T1.BROKER_ID,
			T1.BUY_SELL,
			T1.TOTAL_QUANTITY_TRADED,
			T1.PRICE,
			T1.TOTAL_MARKET_VALUE,
			T1.REASON_CODE,
			T1.BROKER_COMMISSION
	EXCEPT 
	SELECT  ORDER_NUMBER,
			TICKER,
			ACCOUNT,
			BROKER_ID,
			BUY_SELL,
			TOTAL_QUANTITY_TRADED,
			PRICE,
			TOTAL_MARKET_VALUE,
			REASON_CODE,
			BROKER_COMMISSION
	FROM TCA_TRADE
)
UNION ALL
-- AS EXCEPT EXCLUDES DUPLICATES WE HAVE TO APPLY AN EXISTS AS WELL AS AN EXCEPT.
SELECT		'TCA' AS DATA,
			ORDER_NUMBER,
			TICKER,
			ACCOUNT,
			BROKER_ID,
			BUY_SELL,
			TOTAL_QUANTITY_TRADED,
			PRICE,
			TOTAL_MARKET_VALUE,
			REASON_CODE,
			BROKER_COMMISSION
FROM TCA_TRADE T2
WHERE EXISTS
(
	SELECT  T2.ORDER_NUMBER,
			T2.TICKER,
			T2.ACCOUNT,
			T2.BROKER_ID,
			T2.BUY_SELL,
			T2.TOTAL_QUANTITY_TRADED,
			T2.PRICE,
			T2.TOTAL_MARKET_VALUE,
			T2.REASON_CODE,
			T2.BROKER_COMMISSION
	EXCEPT 
	SELECT  ORDER_NUMBER,
			TICKER,
			ACCOUNT,
			BROKER_ID,
			BUY_SELL,
			TOTAL_QUANTITY_TRADED,
			PRICE,
			TOTAL_MARKET_VALUE,
			REASON_CODE,
			BROKER_COMMISSION
	FROM BLOOMBERG_AGREEGATED_DATA
)