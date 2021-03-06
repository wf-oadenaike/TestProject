﻿


CREATE VIEW [dbo].[T_BPS_SECURITY_EQUITY_VIEW]
AS
SELECT distinct [FILE_NAME], [DATE], [IDENTIFIER], 
	 CAST((CASE WHEN ISDATE([DVD_EX_DT]) = 1 THEN [DVD_EX_DT] END) AS [datetime]) AS  [EX_DIVIDEND_DATE]
	,CAST([DVD_FREQ] AS [varchar](20)) AS  [DIVIDEND_FREQUENCY] 
	,CAST((CASE WHEN ISDATE([DVD_PAY_DT]) = 1 THEN [DVD_PAY_DT] END) AS [datetime]) AS  [DIVIDEND_PAY_DATE] 
	,CAST((CASE WHEN ISNUMERIC(DVD_SH_LAST) = 1 THEN [DVD_SH_LAST] END) AS [decimal](26, 12)) AS  [DIVIDEND_PER_SHARE_LAST_NET] 
	,CAST((CASE WHEN ISNUMERIC(LAST_DPS_GROSS) = 1 THEN [LAST_DPS_GROSS] END) AS [decimal](26, 12)) AS   [DIVIDEND_PER_SHARE_LAST_GROSS] 
	,CAST((CASE WHEN ISNUMERIC(EQY_IND_DPS_ANNUAL_GROSS) = 1 THEN [EQY_IND_DPS_ANNUAL_GROSS] END) AS [decimal](26, 6)) AS   [DIVIDEND_PER_SHARE_ANNUAL_GROSS] 
	,CAST([DVD_TYP_LAST] AS [varchar](30)) AS   [DIVIDEND_TYPE] 
	,CAST((CASE WHEN ISDATE(DVD_RECORD_DT) = 1 THEN [DVD_RECORD_DT] END) AS [datetime]) AS   [DIVIDEND_RECORD_DATE] 
	,CAST((CASE WHEN ISDATE([EQY_DVD_STK_EX_DT_CURR]) = 1 THEN [EQY_DVD_STK_EX_DT_CURR] END) AS [datetime]) AS    [CURRENT_STOCK_DIVIDEND_EX_DATE] 
	,CAST((CASE WHEN ISDATE([EQY_DVD_STK_PAY_DT_CURR]) = 1 THEN [EQY_DVD_STK_PAY_DT_CURR] END) AS [datetime] ) AS  [CURRENT_STOCK_DIVIDEND_PAY_DATE] 
	,CAST((CASE WHEN ISNUMERIC([EQY_DVD_STK_PCT_CURR]) = 1 THEN [EQY_DVD_STK_PCT_CURR] END) AS [varchar](10)) AS   [CURRENT_STOCK_DIVIDEND_PCT] 
	,CAST(NULL AS [decimal](26, 6)) AS   [NORMAL_MARKET_SIZE] 
	,CAST((CASE WHEN ISNUMERIC([EQY_SH_OUT]) = 1 THEN [EQY_SH_OUT] END) AS [decimal](26, 6)) AS   [SHARES_OUTSTANDING] 
	,CAST((CASE WHEN ISDATE([EQY_SH_OUT_DT]) = 1 THEN [EQY_SH_OUT_DT] END) AS [datetime]) AS   [SHARES_OUTSTANDING_DATE]
	,CAST(NULL AS [varchar](20)) AS   [IPO] 
	,CAST(NULL AS [decimal](26, 6)) AS   [VOL_WEIGHTED_AVERAGE_PRICE]
	,CAST(NULL AS [decimal](26, 6)) AS   [FUND_NET_ASSET_VALUE] 
	,CAST(NULL AS [decimal](26, 6)) AS   [FUND_TOTAL_ASSETS] 
	,CAST(NULL AS [datetime]) AS   [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE] 
	,CAST(NULL AS [decimal](26, 6)) AS   [TOTAL_VOTING_SHARES] 
	,CAST((CASE WHEN ISNUMERIC(EQY_SH_OUT_REAL) = 1 THEN [EQY_SH_OUT_REAL] END) AS [varchar](20)) AS   [SHARE_OUTSTANDING_REAL_ACTUAL] 
	,CAST((CASE WHEN ISNUMERIC([TOTAL_VOTING_SHARES_VALUE]) = 1 THEN [TOTAL_VOTING_SHARES_VALUE] END) AS [varchar](20)) AS   [TOTAL_VOTING_SHARES_VALUE] 
	,CAST((CASE WHEN ISNUMERIC(EQY_PO_SH_OFFER) = 1 THEN [EQY_PO_SH_OFFER] END) AS [varchar](20)) AS   [LAST_PUBLISHED_OFFER_NO_OF_SHARES] 
	,CAST(NULL AS [varchar](20)) AS   [SHARE_OUTSTANDING_REAL_VALUE] 
	,CAST((CASE WHEN ISNUMERIC([CUR_MKT_CAP]) = 1 THEN [CUR_MKT_CAP] END) AS [varchar](20)) AS   [CURRENT_MARKET_CAP] 
	,pvt.CADIS_SYSTEM_UPDATED
FROM 
(SELECT [FILE_NAME]
      ,[DATE]
      ,[IDENTIFIER]
      ,[FIELD]
	  ,[VALUE]
	  ,[CADIS_SYSTEM_UPDATED]
FROM [dbo].[T_BPS_SECURITY]) p
PIVOT
(
	MIN([VALUE])
FOR [FIELD] IN
( 
	[EQY_SH_OUT],
	[AMT_OUTSTANDING],
	[AMT_ISSUED],
	[DVD_CRNCY],
	[DVD_EX_DT],
	[DVD_FREQ],
	[DVD_PAY_DT],
	[EQY_SH_OUT_DT],
	[TOTAL_VOTING_SHARES_VALUE],
	[EQY_PO_SH_OFFER],
	[EQY_SH_OUT_REAL],
	[DVD_SH_LAST],
	[EQY_IND_DPS_ANNUAL_GROSS],
	[DVD_TYP_LAST],
	[DVD_RECORD_DT],
	[EQY_DVD_STK_EX_DT_CURR],
	[EQY_DVD_STK_PAY_DT_CURR],
	[EQY_DVD_STK_PCT_CURR],
	[CUR_MKT_CAP],
	[LAST_DPS_GROSS]
 )
) AS pvt


