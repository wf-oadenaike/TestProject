﻿
CREATE PROCEDURE [Reporting.Investment].[usp_GeographicalExposure]
	@PositionDate date = NULL
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[usp_EDMPositionsGeographical]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			26/01/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Produce a list of positions for the Investment Ops geography exposure. Temporary until we fix the Price feed.
-- 
-------------------------------------------------------------------------------------- 

	Set NoCount on

DECLARE @AUM TABLE (
	[FUND_SHORT_NAME] VARCHAR(7) NULL,
	[VALUATION_DATE] DATETIME NULL,
	[AUM] DECIMAL(19,2) NULL,
	[IsEstimate] BIT NULL,
	[LastUpdatedDate] DATETIME NULL
)

INSERT INTO @AUM ([FUND_SHORT_NAME], [VALUATION_DATE], [AUM], [IsEstimate], [LastUpdatedDate])
SELECT
	[FUND_SHORT_NAME] ,
	[VALUATION_DATE],
	SUM([VALUE]) AS AUM ,
	[IsEstimate] ,
	MAX([LastUpdatedDate]) AS [LastUpdatedDate]
FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
--WHERE [DESCRIPTION] <> 'Estimated Annual Management Fee'
GROUP BY [FUND_SHORT_NAME], [VALUATION_DATE], [IsEstimate]
	
;WITH CTE_Securities AS
(
	SELECT m.[EDM_SEC_ID]
		  ,COALESCE(o.[SECURITY_NAME], m.[SECURITY_NAME]) AS [SECURITY_NAME]
		  ,COALESCE(o.[SECURITY_DESCRIPTION], m.[SECURITY_DESCRIPTION]) AS [SECURITY_DESCRIPTION]
		  ,COALESCE(o.[SECURITY_SHORTNAME], m.[SECURITY_SHORTNAME]) AS [SECURITY_SHORTNAME]
		  ,COALESCE(o.[ASSET_TYPE], m.[ASSET_TYPE]) AS [ASSET_TYPE]
		  ,COALESCE(o.[SECURITY_TYPE], m.[SECURITY_TYPE]) AS [SECURITY_TYPE]
		  ,COALESCE(o.[CUSIP], m.[CUSIP]) AS [CUSIP]
		  ,COALESCE(o.[ISIN], m.[ISIN]) AS [ISIN]
		  ,COALESCE(o.[SEDOL], m.[SEDOL]) AS [SEDOL]
		  ,COALESCE(o.[TICKER], m.[TICKER]) AS [TICKER]
		  ,COALESCE(o.[VALOREN], m.[VALOREN]) AS [VALOREN]
		  ,COALESCE(o.[WERTPAPIER], m.[WERTPAPIER]) AS [WERTPAPIER]
		  ,COALESCE(o.[SECURITY_ISO_CCY], m.[SECURITY_ISO_CCY]) AS [SECURITY_ISO_CCY]
		  ,COALESCE(o.[RISK_ISO_CCY], m.[RISK_ISO_CCY]) AS [RISK_ISO_CCY]
		  ,COALESCE(o.[FIXED_ISO_CCY], m.[FIXED_ISO_CCY]) AS [FIXED_ISO_CCY]
		  ,COALESCE(o.[INCORPORATION_ISO_CTY], m.[INCORPORATION_ISO_CTY]) AS [INCORPORATION_ISO_CTY]
		  ,COALESCE(o.[DOMICILE_ISO_CTY], m.[DOMICILE_ISO_CTY]) AS [DOMICILE_ISO_CTY]
		  ,COALESCE(o.[ISSUE_COUNTRY_ISO], m.[ISSUE_COUNTRY_ISO]) AS [ISSUE_COUNTRY_ISO]
		  ,COALESCE(o.[RISK_ISO_CTY], m.[RISK_ISO_CTY]) AS [RISK_ISO_CTY]
		  ,COALESCE(o.[MIC_EXCHANGE_CODE], m.[MIC_EXCHANGE_CODE]) AS [MIC_EXCHANGE_CODE]
		  ,COALESCE(o.[STATE_CODE], m.[STATE_CODE]) AS [STATE_CODE]
		  ,COALESCE(o.[ACTIVE_TRADE_INDICATOR], m.[ACTIVE_TRADE_INDICATOR]) AS [ACTIVE_TRADE_INDICATOR]
		  ,COALESCE(o.[144A_INDICATOR], m.[144A_INDICATOR]) AS [144A_INDICATOR]
		  ,COALESCE(o.[PRIVATE_PLACEMENT_INDICATOR], m.[PRIVATE_PLACEMENT_INDICATOR]) AS [PRIVATE_PLACEMENT_INDICATOR]
		  ,COALESCE(o.[ILLIQUID], m.[ILLIQUID]) AS [ILLIQUID]
		  ,COALESCE(o.[QUOTE_TYPE], m.[QUOTE_TYPE]) AS [QUOTE_TYPE]
		  ,COALESCE(o.[DAYS_TO_SETTLE], m.[DAYS_TO_SETTLE]) AS [DAYS_TO_SETTLE]
		  ,COALESCE(o.[TRADE_SETTLEMENT_CALENDAR_CODE], m.[TRADE_SETTLEMENT_CALENDAR_CODE]) AS [TRADE_SETTLEMENT_CALENDAR_CODE]
		  ,COALESCE(o.[UNIQUE_BLOOMBERG_ID], m.[UNIQUE_BLOOMBERG_ID]) AS [UNIQUE_BLOOMBERG_ID]
		  ,COALESCE(o.[BBG_EXCHANGE_CODE], m.[BBG_EXCHANGE_CODE]) AS [BBG_EXCHANGE_CODE]
		  ,COALESCE(o.[BBG_SECTOR], m.[BBG_SECTOR]) AS [BBG_SECTOR]
		  ,COALESCE(o.[BBG_SUBSECTOR], m.[BBG_SUBSECTOR]) AS [BBG_SUBSECTOR]
		  ,COALESCE(o.[BBG_GROUP], m.[BBG_GROUP]) AS [BBG_GROUP]
		  ,COALESCE(o.[IS_IPO], m.[IS_IPO]) AS [IS_IPO]
		  ,COALESCE(o.[PARSEKEYABLE_DESCRIPTION], m.[PARSEKEYABLE_DESCRIPTION]) AS [PARSEKEYABLE_DESCRIPTION]
		  ,COALESCE(o.[CUR_MAR_CAP], m.[CUR_MAR_CAP], oe.[CURRENT_MARKET_CAP], e.[CURRENT_MARKET_CAP]) AS [CURRENT_MARKET_CAP]
	  FROM 
		[dbo].[T_MASTER_SEC] m
	  LEFT JOIN 
		[dbo].[T_OVERRIDE_SEC] o ON 
			m.[EDM_SEC_ID] = o.[EDM_SEC_ID]
	 LEFT JOIN
		[dbo].[T_MASTER_SEC_EQUITY] e ON 
			m.[EDM_SEC_ID] = e.[EDM_SEC_ID]
	LEFT JOIN
		[dbo].[T_OVERRIDE_SEC_EQUITY] oe ON 
			m.[EDM_SEC_ID] = oe.[EDM_SEC_ID]
),
CTE_FUND AS
(
SELECT [EDM_FND_ID]
      ,[SHORT_NAME]
      ,[LONG_NAME]
      ,[EDM_FUND_GROUP_ID]
      ,[START_DATE]
      ,[FUND_TYPE]
      ,[STATUS]
      ,[BASE_CURRENCY]
      ,[LOCATION]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,'EOD' AS [VALUATION_PERIOD]
  FROM [dbo].[T_MASTER_FND] 
),
CTE_FUND_AUM AS
(
    -- Use the estimate because it is derived from the market value of positions used in this calculation
	-- Change so dont use the estimate RFC 20/10/2016
	SELECT
		e.FUND_SHORT_NAME AS FUND_SHORT_NAME,
		MAX(e.[VALUATION_DATE]) AS [POSITION_DATE],
		SUM(e.AUM) AS  AUM ,
		0 AS [IsEstimate] ,
		MAX(e.LastUpdatedDate) AS  [LastUpdatedDate]
	FROM @AUM e
	WHERE e.IsEstimate = 0
	GROUP BY e.FUND_SHORT_NAME
),
CTE_FX AS (
	SELECT 
		   m.[FXRATE_ID]
		  ,m.[DATE]
		  ,COALESCE(o.[FROM_ISO_CURRENCY_CODE], m.[FROM_ISO_CURRENCY_CODE]) AS [FROM_ISO_CURRENCY_CODE]
		  ,COALESCE(o.[TO_ISO_CURRENCY_CODE], m.[TO_ISO_CURRENCY_CODE]) AS [TO_ISO_CURRENCY_CODE]
		  ,COALESCE(o.[SPOT_RATE], m.[SPOT_RATE]) AS [SPOT_RATE]
		  ,COALESCE(o.[1_MONTH_FORWARD_RATE], m.[1_MONTH_FORWARD_RATE]) AS [1_MONTH_FORWARD_RATE]
		  ,COALESCE(o.[2_MONTH_FORWARD_RATE], m.[2_MONTH_FORWARD_RATE]) AS [2_MONTH_FORWARD_RATE]
		  ,COALESCE(o.[3_MONTH_FORWARD_RATE], m.[3_MONTH_FORWARD_RATE]) AS [3_MONTH_FORWARD_RATE]
		  ,COALESCE(o.[6_MONTH_FORWARD_RATE], m.[6_MONTH_FORWARD_RATE]) AS [6_MONTH_FORWARD_RATE]
		  ,COALESCE(o.[1_YEAR_FORWARD_RATE], m.[1_YEAR_FORWARD_RATE]) AS [1_YEAR_FORWARD_RATE]
		  ,COALESCE(o.[DATA_QUALITY], m.[DATA_QUALITY]) AS [DATA_QUALITY]
	  FROM 
		[dbo].[T_MASTER_FXRATE] m
	  INNER JOIN
		(
			SELECT 
				[FXRATE_ID]
				,MAX([DATE]) AS [DATE]
			 FROM 
			[dbo].[T_MASTER_FXRATE]
			WHERE [DATE] <= @PositionDate
			GROUP BY [FXRATE_ID]
		) data on data.[FXRATE_ID] = m.[FXRATE_ID] AND data.[DATE] = m.[DATE]
	  LEFT JOIN
		[dbo].[T_OVERRIDE_FXRATE] o ON
			m.[FXRATE_ID] = o.[FXRATE_ID] AND
			m.[DATE] = o.[DATE]
)
SELECT 
		[POSITION_DATE]
      ,[FUND_SHORT_NAME]
	  ,[EDM_SEC_ID]
	  ,[SECURITY_NAME]
	  ,[TICKER]
	  ,[PARSEKEYABLE_DESCRIPTION]
	  ,[SECURITY_ISO_CCY]
      ,[LONG_SHORT_IND]
      ,[QUANTITY]
	  ,[IsUnquoted]
	  ,[ISSUE_COUNTRY_ISO]
	  ,EODPrice
	  ,MidPrice
	  ,PreviousEODPrice
	  ,PreviousMidPrice
	  ,PriceCCY
	  ,Multiplier
	  ,[AUM] AS [FUND_MARKET_VALUE_BASE]
	  ,[FUND_BASE_CURRENCY]
	  ,[FUND_VALUATION_PERIOD]
	  ,FX
	  ,PreviousFx
	  ,MARKET_VALUE_BASE
	  , MARKET_VALUE_BASE / [AUM] AS [Weight]
	  , CURRENT_MARKET_CAP
	  , CURRENT_MARKET_CAP_USD
	  ,AUM_DATE
	  ,PRICE_DATE
	  FROM
	  (
SELECT 
	  pos.[POSITION_DATE]
      ,pos.[FUND_SHORT_NAME]
	  ,pos.[EDM_SEC_ID]
	  ,sec.[SECURITY_NAME]
	  ,sec.[TICKER]
	  ,pos.[PARSEKEYABLE_DESCRIPTION]
	  ,pos.[SECURITY_ISO_CCY]
      ,pos.[LONG_SHORT_IND]
      ,pos.[QUANTITY]
	  ,pos.[IsUnquoted]
	  ,sec.[ISSUE_COUNTRY_ISO]
	  ,pos.EODPrice
	  ,pos.MidPrice
	  ,pos.PreviousEODPrice
	  ,pos.PreviousMidPrice
	  ,COALESCE(pos.[SECURITY_ISO_CCY], sec.[SECURITY_ISO_CCY]) AS PriceCCY
	  ,pos.Multiplier
	  ,aum.[AUM]
		, fund.[BASE_CURRENCY] AS [FUND_BASE_CURRENCY]
		, fund.[VALUATION_PERIOD] AS [FUND_VALUATION_PERIOD]
		, pos.FX
		, pos.PreviousFX
		, pos.MARKET_VALUE_BASE
		, sec.CURRENT_MARKET_CAP
		, (CASE 
			WHEN COALESCE(pos.[SECURITY_ISO_CCY], sec.[SECURITY_ISO_CCY]) = 'USD' THEN CONVERT(DECIMAL(18,2), sec.CURRENT_MARKET_CAP) 
			WHEN COALESCE(pos.[SECURITY_ISO_CCY], sec.[SECURITY_ISO_CCY]) = 'GBP' THEN CONVERT(DECIMAL(18,2), sec.CURRENT_MARKET_CAP)  * fxGBPUSD.[SPOT_RATE]
			ELSE CONVERT(DECIMAL(18,2), sec.CURRENT_MARKET_CAP)  * fx.[SPOT_RATE] * fxGBPUSD.[SPOT_RATE] -- Convert to GBP THEN to USD
		END) AS CURRENT_MARKET_CAP_USD
		,aum.LastUpdatedDate AS AUM_DATE
		,pos.PRICE_DATE
  FROM 
	[Reporting.Investment].[ufn_GetFundHoldingsMarketValue](@PositionDate) pos
LEFT JOIN 
	CTE_Securities sec ON 
		pos.[EDM_SEC_ID] = sec.[EDM_SEC_ID]
LEFT JOIN
	CTE_FUND_AUM aum ON
	--	aum.[POSITION_DATE] = pos.[POSITION_DATE] AND
		aum.[FUND_SHORT_NAME] = pos.[FUND_SHORT_NAME]
LEFT JOIN
	CTE_FUND fund ON
		pos.[FUND_SHORT_NAME] = fund.[SHORT_NAME]
LEFT JOIN 
	CTE_FX fxGBPUSD ON 
		fxGBPUSD.[FXRATE_ID] = 'GBPUSD'
LEFT JOIN 
	CTE_FX fx ON
		pos.[SECURITY_ISO_CCY] + 'GBP' = fx.[FXRATE_ID]
	) data
		ORDER BY [POSITION_DATE], [FUND_SHORT_NAME], EDM_SEC_ID
