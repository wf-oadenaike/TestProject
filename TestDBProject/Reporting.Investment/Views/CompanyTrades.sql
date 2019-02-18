CREATE VIEW [Reporting.Investment].[CompanyTrades]
	AS
WITH CTE_HIST AS (
SELECT
	[FUND_SHORT_CODE]
	,UnquotedCompanyId
	,ListedCompanyId
      ,[EntryDate]
      ,[AssetDescription]
      ,[LocalCurrencyCode]
      ,[ISIN]
      ,[SEDOL]
      ,[BloombergGlobalExchangeID]
      ,[BloombergTickerID]
      ,[Shares]
      ,[TransactionPriceBase]
      ,[TransactionAmtBase]
  FROM [Unquoted].[ConfirmedTrades]
  ), CTE_TRADES AS (
  SELECT 
	LEFT(TraderAccountName, 6) AS FUND_SHORT_CODE
      ,us.[UnquotedCompanyId]
      ,ls.[ListedCompanyId]
	  ,CONVERT(DATE,TradeDate) AS TradeDate
	  , sec.SECURITY_NAME AS Description
	  , sec.SECURITY_ISO_CCY AS CurrencyCode
	  , sec.ISIN
	  , sec.SEDOL
	  , NULL AS BBGGlobalId
	  , trade.BLOOMBERGIDENTIFIER AS Ticker
	  , trade.[UniqueBloombergID]
	  , trade.BuySellCoverShortFlag AS BuySellFlag
	  , ROUND(trade.TradeAmount,0) AS Quantity
	  , CONVERT(FLOAT,trade.Price) AS PriceLocal
	  , CONVERT(DECIMAL(18,2), trade.FundccyPrincipal) AS NotionalBase
	  , 'BBG' AS Source
  FROM [dbo].[T_MASTER_BBAIM_TRADE] trade
  LEFT JOIN [dbo].[T_MASTER_SEC] sec ON sec.[UNIQUE_BLOOMBERG_ID] = trade.[UniqueBloombergID]
  LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = trade.[UniqueBloombergID]
  LEFT JOIN [Unquoted].[ListedSecurities] ls ON ls.[UniqueBloombergId] = trade.[UniqueBloombergID]
  WHERE CancelDueToCorrection <> 'Y'
  )
  SELECT 
   data.FUND_SHORT_CODE
   ,data.Source 
   ,COALESCE(uc.UnquotedCompanyName, lc.ListedCompanyName) AS Company
      ,data.[UnquotedCompanyId]
      ,data.[ListedCompanyId]
	  ,data.TradeDate
	  , data.Description
	  , data.CurrencyCode
	  , data.ISIN
	  , data.SEDOL
	  , data.BBGGlobalId
	  , data.Ticker
	  , data.[UniqueBloombergID]
	  , data.BuySellFlag
	  , data.Quantity
	  , data.PriceLocal
	  , data.NotionalBase
	  , 1 AS IsActualTrade
  FROM (
  SELECT 
	trades.FUND_SHORT_CODE
      ,trades.[UnquotedCompanyId]
      ,trades.[ListedCompanyId]
	  ,trades.TradeDate
	  , trades.Description
	  , trades.CurrencyCode
	  , trades.ISIN
	  , trades.SEDOL
	  , trades.BBGGlobalId
	  , trades.Ticker
	  , trades.[UniqueBloombergID]
	  , trades.BuySellFlag
	  , trades.Quantity
	  , trades.PriceLocal
	  , trades.NotionalBase
	  , trades.Source
  FROM CTE_TRADES trades
  LEFT JOIN [dbo].[T_MASTER_SEC] sec ON sec.[UNIQUE_BLOOMBERG_ID] = trades.[UniqueBloombergID]
  LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = trades.[UniqueBloombergID]
  LEFT JOIN [Unquoted].[ListedSecurities] ls ON ls.[UniqueBloombergId] = trades.[UniqueBloombergID]
 
  UNION ALL
	SELECT
	[FUND_SHORT_CODE]
	,UnquotedCompanyId
	,ListedCompanyId
      ,[EntryDate]
      ,[AssetDescription]
      ,[LocalCurrencyCode]
      ,[ISIN]
      ,[SEDOL]
      ,[BloombergGlobalExchangeID]
      ,[BloombergTickerID]
	  , NULL
	  , (CASE WHEN CONVERT(DECIMAL(18,2),[TransactionAmtBase]) > 0.00 THEN 'S' ELSE 'B' END) AS BuySellFlag
      ,ROUND([Shares],0)
      ,CONVERT(FLOAT,[TransactionPriceBase])
      ,ABS([TransactionAmtBase])
	  ,'NT'
  FROM CTE_HIST hist
  WHERE CONVERT(DATE,hist.[EntryDate]) < '16 Dec 2015'
  ) data
  LEFT JOIN [Organisation].[UnquotedCompanies] uc ON uc.UnquotedCompanyId = data.UnquotedCompanyId
  LEFT JOIN [Unquoted].[ListedCompanies] lc ON lc.ListedCompanyId = data.ListedCompanyId
  UNION ALL 
  SELECT 
	DISTINCT
		NULL AS FundCode
		,'MW Flow'
		,uc.UnquotedCompanyName
      ,ucr.[UnquotedCompanyId]
	  , NULL
	  ,(CASE WHEN DATEPART(hh,[EventDate]) = 23 THEN DATEADD(dd, 1, CONVERT(DATE, EventDate)) ELSE [EventDate] END)
      ,[EventType]
      ,COALESCE(ucr.[CurrencyCode], uc.[CurrencyCode] )
	  ,NULL
	  ,NULL
	  ,NULL
	  ,NULL
	  ,NULL
	  ,(CASE 
			WHEN EventType = 'Further Funding' AND [FurtherFundingAmount] > 0 THEN 'B' 
			WHEN EventType = 'Further Funding' AND [FurtherFundingAmount] < 0 THEN 'S' END)
      ,NULL --Quantity
	  ,[RevaluationPrice]
	  ,ABS([FurtherFundingAmount])
	  , 0
  FROM [Organisation].[UnquotedCompanyRevaluation] ucr 
  INNER JOIN [Organisation].[UnquotedCompanies] uc ON uc.UnquotedCompanyId = ucr.UnquotedCompanyId
  WHERE [EventDate] > 
  (
	SELECT MAX(TradeDate) FROM CTE_TRADES
  )
