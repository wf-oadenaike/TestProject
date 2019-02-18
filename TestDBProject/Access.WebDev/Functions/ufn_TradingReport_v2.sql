CREATE FUNCTION [Access.WebDev].[ufn_TradingReport_v2]
(
	@TradeDateFrom DATE = NULL,
	@TradeDateTo DATE = NULL
)
RETURNS @Output TABLE (
		AsOfTradeDate					DATETIME NULL,
		Fund_Short_Name					VARCHAR(50) NULL,
		TradeBuySell					VARCHAR(50) NULL,
		Security_Name					VARCHAR(100) NULL,
		SecurityCurrencyISOCode			VARCHAR(100) NULL,
		TotalTradedAmount				DECIMAL(19,2) NULL,
		SettlementCcyPrincipal_LocalCCY DECIMAL(19,2) NULL,
		SettlementCcyPrincipal_GBP		DECIMAL(19,2) NULL,
		AveragePrice_LocalCCY			DECIMAL(19,2) NULL,
		Spot_Rate						DECIMAL(19,2) NULL,
		DB_UpdatedDateTime				DATETIME NULL
)
AS
/******************************
** Desc:
** Auth: D.Fanning
** Date: 04/05/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1013     01/10/2008  D.Fanning   Refactor function to aggregate trades for AsTradeDate, Account, SecurityName, BuySell
**										Also amended FX calc
** DAP-1261		08/08/2017  D.Fanning   Add database updated date\time, add clauses to remove cancelled\corrected trades
** DAP-1305		27/09/2017  D.Fanning   Replace AVG with weighted average for Price and fx spot
** DAP-1305		27/09/2017  D.Fanning   NULL fix for fx_spot
*******************************/
BEGIN
	DECLARE @latestFX DATETIME

	SET @latestFX = (SELECT MAX([DATE]) FROM [dbo].[T_MASTER_FXRATE])

	IF @TradeDateFrom IS NULL
		SET @TradeDateFrom = (SELECT MAX(CAST(TradeDate as date)) FROM [dbo].[T_MASTER_BBAIM_TRADE]);

	IF @TradeDateTo IS NULL
		SET @TradeDateTo = @TradeDateFrom;

	INSERT INTO @Output
	(
		AsOfTradeDate,
		Fund_Short_Name,
		TradeBuySell,
		Security_Name,
		SecurityCurrencyISOCode,
		TotalTradedAmount,
		SettlementCcyPrincipal_LocalCCY,
		SettlementCcyPrincipal_GBP,
		AveragePrice_LocalCCY,
		Spot_Rate,
		DB_UpdatedDateTime
	)
	SELECT 
		CAST(tt.AsOfTradeDate as date) AS AsOfTradeDate
		,tt.TraderAccountName AS Fund_Short_Name
		,tt.[BuySellCoverShortFlag] AS TradeBuySell
		,ss.[SECURITY_NAME] AS Security_Name
		,max(tt.[SecurityCurrencyISOCode]) as SecurityCurrencyISOCode
		,sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount])) as TotalTradedAmount
		,sum(CONVERT(DECIMAL(20, 2), tt.[SettlementCcyPrincipal])) as SettlementCcyPrincipal_LocalCCY
		,sum(CONVERT(DECIMAL(20, 2), tt.[SettlementCcyPrincipal]) * ISNULL(FX.SPOT_RATE, 1)) as SettlementCcyPrincipal_GBP
		,sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount]) * CONVERT(DECIMAL(20, 4), tt.Price)) / sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount])) as AveragePrice_LocalCCY
		,isnull(sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount]) * CONVERT(DECIMAL(20, 4), FX.SPOT_RATE)) / sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount])), 1) as Spot_Rate
		,max(CONVERT(DATETIME, tt.CADIS_SYSTEM_UPDATED)) as DB_UpdatedDateTime
	FROM 
		[dbo].[T_MASTER_BBAIM_TRADE]	tt
	LEFT OUTER  JOIN
		[dbo].[T_MASTER_FXRATE]			FX	ON FX.[DATE] = @latestFX 
											AND FX.FROM_ISO_CURRENCY_CODE = tt.[SecurityCurrencyISOCode]
											AND FX.TO_ISO_CURRENCY_CODE = 'GBP'
	LEFT OUTER JOIN 
		[dbo].[T_MASTER_SEC]			SS	ON tt.[UniqueBloombergID] = ss.[UNIQUE_BLOOMBERG_ID]
	WHERE 
		CAST(tt.AsOfTradeDate as date) >= @TradeDateFrom
	AND CAST(tt.AsOfTradeDate as date) <= @TradeDateTo
	AND tt.CancelDueToCorrection		= 'N'
	AND tt.TransactionType				<> 'PXP'
	GROUP BY 
		CAST(tt.AsOfTradeDate as date),
		tt.TraderAccountName,
		tt.[BuySellCoverShortFlag],
		ss.[SECURITY_NAME]	
	ORDER BY 
		CAST(tt.AsOfTradeDate as date),
		tt.TraderAccountName,
		ss.[SECURITY_NAME],
		tt.[BuySellCoverShortFlag]


   RETURN
   
END
