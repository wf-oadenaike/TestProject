CREATE PROCEDURE [Reporting].[usp_EDMDIPsGetDIPsBreakdown]
	@RunDate date = NULL
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[usp_EDMDIPsGetDIPsBreakdown]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			26/01/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Obtains the deals in progress data for the email to the business.
-- 
-------------------------------------------------------------------------------------- 

Set NoCount on
	
IF @RunDate IS NULL
BEGIN
	SET @RunDate = CONVERT(DATE, GETDATE())
END

;WITH CTE_Subs AS (SELECT
	  COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS [Agent_Name]
      ,SUM(VALUE) AS Subscriptions
  FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
  WHERE [TYPE] IN ('Sale','Class Switch Sale') AND CONVERT(DATE, VALUATION_POINT) = @RunDate
  AND MAIN_OWNER_NAME <> 'Northern Trust Nominees (Ireland) Ltd'
  GROUP BY COALESCE([AGENT_NAME], [MAIN_OWNER_NAME])
), CTE_Reds AS (
SELECT
	COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS [Agent_Name]
    ,SUM(VALUE) AS Redemptions
FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
WHERE [TYPE] IN ('Repurchase','Class Switch Repurchase') AND CONVERT(DATE, VALUATION_POINT) = @RunDate
AND MAIN_OWNER_NAME <> 'Northern Trust Nominees (Ireland) Ltd'
GROUP BY COALESCE([AGENT_NAME], [MAIN_OWNER_NAME])
  ), CTE_Agents AS
  (
	SELECT DISTINCT COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS  [AGENT_NAME]
	FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
	WHERE CONVERT(DATE, VALUATION_POINT) = @RunDate 
	AND MAIN_OWNER_NAME <> 'Northern Trust Nominees (Ireland) Ltd'
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
