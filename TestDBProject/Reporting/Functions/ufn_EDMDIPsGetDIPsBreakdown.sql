CREATE FUNCTION [Reporting].[ufn_EDMDIPsGetDIPsBreakdown]
(
	@RunDate DATE = NULL
)
RETURNS @Output TABLE (
	 AgentName VARCHAR(256) NULL 
	,Subscriptions MONEY NULL
	,SubscriptionsDisplay VARCHAR(256) NULL
	,Redemptions MONEY NULL
	,RedemptionsDisplay VARCHAR(256) NULL
	,Total MONEY NULL
	,TotalDisplay VARCHAR(256) NULL
)

AS
BEGIN
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
-- R Carter 28/09/2016 Cloned from [Reporting].[usp_EDMDIPsGetDIPsBreakdown] so can be used by WebService
-------------------------------------------------------------------------------------- 

	
IF @RunDate IS NULL
	SET @RunDate = (SELECT MAX(valuation_point) from [dbo].[T_MASTER_DEALS_IN_PROGRESS]);


;WITH CTE_Subs AS (SELECT
	  COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS [Agent_Name]
      ,SUM(VALUE) AS Subscriptions
  FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
  WHERE [TYPE] = 'Sale' AND CONVERT(DATE, VALUATION_POINT) = @RunDate
  GROUP BY COALESCE([AGENT_NAME], [MAIN_OWNER_NAME])
), CTE_Reds AS (
SELECT
	COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS [Agent_Name]
    ,SUM(VALUE) AS Redemptions
FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
WHERE [TYPE] = 'Repurchase' AND CONVERT(DATE, VALUATION_POINT) = @RunDate
GROUP BY COALESCE([AGENT_NAME], [MAIN_OWNER_NAME])
  ), CTE_Agents AS
  (
	SELECT DISTINCT COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS  [AGENT_NAME]
	FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
	WHERE CONVERT(DATE, VALUATION_POINT) = @RunDate
)
  INSERT INTO @Output
    (AgentName
	,Subscriptions
	,SubscriptionsDisplay
	,Redemptions
	,RedemptionsDisplay
	,Total
	,TotalDisplay)
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

   RETURN
   
END
