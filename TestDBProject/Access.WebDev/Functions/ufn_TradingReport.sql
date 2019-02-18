CREATE FUNCTION [Access.WebDev].[ufn_TradingReport]
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
		Spot_Rate						DECIMAL(19,2) NULL
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
** DAP-1013     10/01/2017  D.Fanning   Refactor function to aggregate trades for AsTradeDate, Account, SecurityName, BuySell
**										Also amended FX calc
** DAP-1274     10/08/2017  D.Fanning   FX fix, use latest available FX data
**
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
		Spot_Rate
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
		,avg(CONVERT(DECIMAL(20, 4), tt.Price)) as AveragePrice_LocalCCY
		,avg(ISNULL(FX.SPOT_RATE, 1)) as Spot_Rate
	FROM 
		[dbo].[T_MASTER_BBAIM_TRADE]	tt
	LEFT OUTER  JOIN
		[dbo].[T_MASTER_FXRATE]			FX	ON FX.[DATE] =  @latestFX
											AND FX.FROM_ISO_CURRENCY_CODE = tt.[SecurityCurrencyISOCode]
											AND FX.TO_ISO_CURRENCY_CODE = 'GBP'
	LEFT OUTER JOIN 
		[dbo].[T_MASTER_SEC]			SS	ON tt.[UniqueBloombergID] = ss.[UNIQUE_BLOOMBERG_ID]
	WHERE 
		CAST(tt.AsOfTradeDate as date) >= @TradeDateFrom
	AND CAST(tt.AsOfTradeDate as date) <= @TradeDateTo
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





