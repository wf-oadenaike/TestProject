
CREATE PROCEDURE [Reporting].[usp_EDMGetFeederFundBreakdown]
	@RunDate date = NULL
AS
Set NoCount on
	
IF @RunDate IS NULL
BEGIN
	SET @RunDate = CONVERT(DATE, GETDATE())
END

;WITH CTE_Subs AS (
 SELECT
	  COALESCE([RegisterName], [AgentName]) AS [Agent_Name]
      ,SUM([EstConfInvestorAmt] * ISNULL(fx.SPOT_RATE, 1)) AS Subscriptions
  FROM [Operation].[WEIFFeederFundFlowBreakdown]
  LEFT JOIN (
  SELECT SPOT_RATE, FROM_ISO_CURRENCY_CODE FROM [dbo].[T_MASTER_FXRATE]
	 WHERE [DATE] = (
	SELECT MAX([DATE])
		FROM [dbo].[T_MASTER_FXRATE]
		WHERE [DATE] < @RunDate
		) AND TO_ISO_CURRENCY_CODE = 'GBP'
  ) fx ON FROM_ISO_CURRENCY_CODE = [ShareClassCurrency]
  WHERE [Dealtype] = 'Subscription' AND TradeDate = @RunDate
  GROUP BY COALESCE([RegisterName], [AgentName])
), CTE_Reds AS (
SELECT
	  COALESCE([RegisterName], [AgentName]) AS [Agent_Name]
      ,SUM([EstConfInvestorAmt] * ISNULL(fx.SPOT_RATE, 1)) AS Redemptions
  FROM [Operation].[WEIFFeederFundFlowBreakdown]
  LEFT JOIN (
  SELECT SPOT_RATE, FROM_ISO_CURRENCY_CODE FROM [dbo].[T_MASTER_FXRATE]
	 WHERE [DATE] = (
	SELECT MAX([DATE])
		FROM [dbo].[T_MASTER_FXRATE]
		WHERE [DATE] < @RunDate
		) AND TO_ISO_CURRENCY_CODE = 'GBP'
  ) fx ON FROM_ISO_CURRENCY_CODE = [ShareClassCurrency]
  WHERE [Dealtype] <> 'Subscription' AND TradeDate = @RunDate
  GROUP BY COALESCE([RegisterName], [AgentName])
  ), CTE_Agents AS
  (
	SELECT DISTINCT COALESCE([RegisterName], [AgentName]) AS  [AGENT_NAME]
	FROM [Operation].[WEIFFeederFundFlowBreakdown]
	WHERE TradeDate = @RunDate
)
SELECT 
	a.[AGENT_NAME]
	, ISNULL(s.Subscriptions,0) AS Subscriptions
	, PARSENAME(CONVERT(varchar, CONVERT(MONEY, ISNULL(s.Subscriptions,0)), 1),2) AS SubscriptionsDisplay
	, ISNULL(r.Redemptions,0)  *-1 AS Redemptions
	, PARSENAME(CONVERT(varchar, CONVERT(MONEY,  ISNULL(r.Redemptions,0) * -1), 1),2) AS RedemptionsDisplay
	, ISNULL(s.Subscriptions,0) + ISNULL(r.Redemptions,0) AS Total
	, PARSENAME(CONVERT(varchar, CONVERT(MONEY, ISNULL(s.Subscriptions,0) + ISNULL(r.Redemptions,0)), 1),2) AS TotalDisplay
FROM CTE_Agents a
LEFT JOIN
	CTE_Subs s ON a.AGENT_NAME = s.[Agent_Name]
LEFT JOIN
	CTE_Reds r ON a.AGENT_NAME = r.[Agent_Name]
WHERE a.[AGENT_NAME] IS NOT NULL
ORDER BY ISNULL(s.Subscriptions,0) + ISNULL(r.Redemptions,0) DESC

