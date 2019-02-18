CREATE FUNCTION [Access.WebDev].[ufn_TradingReportSummary_v1]
(
	@TradeDateFrom DATE = NULL,
	@TradeDateTo DATE = NULL
)
RETURNS @Output TABLE (
		Fund_Short_Name					VARCHAR(50) NULL,
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
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1305     01/10/2008  D.Fanning   Create trade summary showing net positions for given dates.
**										https://tasks.woodfordfunds.com/browse/DAP-1305
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
		Fund_Short_Name,
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
		x.Fund_Short_Name
		,x.Security_Name
		,max(x.SecurityCurrencyISOCode) as SecurityCurrencyISOCode
		,sum(x.TotalTradedAmount * (CASE WHEN x.TradeBuySell = 'S' THEN -1 ELSE 1 END)) as TotalTradedAmount
		,sum(x.SettlementCcyPrincipal_LocalCCY * (CASE WHEN x.TradeBuySell = 'S' THEN -1 ELSE 1 END)) as SettlementCcyPrincipal_LocalCCY
		,sum(x.SettlementCcyPrincipal_GBP * (CASE WHEN x.TradeBuySell = 'S' THEN -1 ELSE 1 END)) as SettlementCcyPrincipal_GBP
		,avg(x.AveragePrice_LocalCCY) as AveragePrice_LocalCCY
		,avg(x.Spot_Rate) as Spot_Rate
		,max(x.DB_UpdatedDateTime) as DB_UpdatedDateTime
	FROM
	(
		SELECT 
			tt.TraderAccountName AS Fund_Short_Name
			,tt.[BuySellCoverShortFlag] AS TradeBuySell
			,ss.[SECURITY_NAME] AS Security_Name
			,max(tt.[SecurityCurrencyISOCode]) as SecurityCurrencyISOCode
			,sum(CONVERT(DECIMAL(20, 2), ISNULL(tt.[TradeAmount], 0))) as TotalTradedAmount
			,sum(CONVERT(DECIMAL(20, 2), ISNULL(tt.[SettlementCcyPrincipal], 0))) as SettlementCcyPrincipal_LocalCCY
			,sum(CONVERT(DECIMAL(20, 2), ISNULL(tt.[SettlementCcyPrincipal], 0)) * ISNULL(FX.SPOT_RATE, 1)) as SettlementCcyPrincipal_GBP
			,sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount]) * CONVERT(DECIMAL(20, 4), tt.Price)) / sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount])) as AveragePrice_LocalCCY
			,isnull(sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount]) * CONVERT(DECIMAL(20, 4), FX.SPOT_RATE)) / sum(CONVERT(DECIMAL(20, 2), tt.[TradeAmount])), 1) as Spot_Rate
			,max(CONVERT(DATETIME, tt.CADIS_SYSTEM_UPDATED)) as DB_UpdatedDateTime
		FROM 
			[dbo].[T_MASTER_BBAIM_TRADE]	tt
		LEFT OUTER  JOIN
			[dbo].[T_MASTER_FXRATE]			FX	ON FX.[DATE] = @TradeDateTo 
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
			tt.TraderAccountName,
			tt.[BuySellCoverShortFlag],
			ss.[SECURITY_NAME]	
	) X
	GROUP BY 
		x.Fund_Short_Name
		,x.Security_Name
	ORDER BY 
		x.Fund_Short_Name	
		,x.Security_Name

   RETURN
   
END
