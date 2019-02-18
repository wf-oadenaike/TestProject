CREATE PROCEDURE [Reporting].[usp_EDMDailyTradesByFund]
	@Date DATE = NULL
AS
	IF @Date IS NULL
	BEGIN
		SET @Date = CONVERT(DATE, GETDATE())
	END

	;WITH CTE_PORT AS (
		SELECT
			TraderAccountName AS Portfolio
			,SUM(CASE WHEN SecurityCurrencyISOCode = 'GBP' THEN (CASE WHEN BuySellCoverShortFlag = 'S' THEN -1.0 WHEN BuySellCoverShortFlag = 'B' THEN 1.0 END) * CONVERT(DECIMAL(18,2),[PrincipalLoanAmount]) END) AS GBP
			,SUM(CASE WHEN SecurityCurrencyISOCode = 'USD' THEN (CASE WHEN BuySellCoverShortFlag = 'S' THEN -1.0 WHEN BuySellCoverShortFlag = 'B' THEN 1.0 END) * CONVERT(DECIMAL(18,2),[PrincipalLoanAmount]) END) AS USD
			,SUM(CASE WHEN SecurityCurrencyISOCode = 'EUR' THEN (CASE WHEN BuySellCoverShortFlag = 'S' THEN -1.0 WHEN BuySellCoverShortFlag = 'B' THEN 1.0 END) * CONVERT(DECIMAL(18,2),[PrincipalLoanAmount]) END) AS EUR
			,SUM(CASE WHEN SecurityCurrencyISOCode = 'CHF' THEN (CASE WHEN BuySellCoverShortFlag = 'S' THEN -1.0 WHEN BuySellCoverShortFlag = 'B' THEN 1.0 END) * CONVERT(DECIMAL(18,2),[PrincipalLoanAmount]) END) AS CHF
			,SUM(CASE WHEN SecurityCurrencyISOCode = 'NOK' THEN (CASE WHEN BuySellCoverShortFlag = 'S' THEN -1.0 WHEN BuySellCoverShortFlag = 'B' THEN 1.0 END) * CONVERT(DECIMAL(18,2),[PrincipalLoanAmount]) END) AS NOK
		FROM 
			[dbo].[T_MASTER_BBAIM_TRADE]
		WHERE 
			--TransactionType IN ('OA')
			--AND 
			CONVERT(DATE,AsOfTradeDate) = @Date
			AND CancelDueToCorrection <> 'Y'
		GROUP BY 
			TraderAccountName
	)
	SELECT 
		Portfolio
		,GBP
		,USD
		,EUR
		,CHF
		,NOK
	FROM 
		CTE_PORT
	UNION ALL
	SELECT 
		'Total', SUM(GBP), SUM(USD), SUM(EUR), SUM(CHF), SUM(NOK)
	FROM 
		CTE_PORT
