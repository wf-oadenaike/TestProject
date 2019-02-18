CREATE PROCEDURE [Reporting].[usp_EDMDailyTradesBySecurity]
	@Date DATE = NULL
AS
	IF @Date IS NULL
	BEGIN
		SET @Date = CONVERT(DATE, GETDATE())
	END

	SELECT 
		SECURITY_NAME AS SecurityName,
		BuySellCoverShortFlag AS BuySell,
		CONVERT(INT,SUM(CONVERT(DECIMAL(18,6),TradeAmount))) AS TradeAmount,
		SUM(CONVERT(DECIMAL(18,6),Price) * CONVERT(DECIMAL(18,6),TradeAmount)) / SUM(CONVERT(DECIMAL(18,6),TradeAmount)) AS AveragePrice,
		SUM(CONVERT(DECIMAL(18,2),[PrincipalLoanAmount])) AS Consideration,
		(CASE WHEN OMReasonCode IS NOT NULL THEN 1 ELSE 0 END) AS IsSpecialTrade
	FROM 
		[dbo].[T_MASTER_BBAIM_TRADE] t
		LEFT JOIN [dbo].[T_MASTER_SEC] s ON t.[UniqueBloombergID] = s.UNIQUE_BLOOMBERG_ID
	WHERE 
		--TransactionType IN ('OA')
		--AND 
		CONVERT(DATE,AsOfTradeDate) = @Date 
		AND CancelDueToCorrection <> 'Y'
	GROUP BY 
		SECURITY_NAME, BuySellCoverShortFlag, (CASE WHEN OMReasonCode IS NOT NULL THEN 1 ELSE 0 END)
	ORDER BY 
		SECURITY_NAME
