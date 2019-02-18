CREATE FUNCTION [Access.WebDev].[ufn_EDMDIPsGetDIPsBreakdown]
(
	@RunDate DATE = NULL
)
RETURNS @Output TABLE (
	 AgentName VARCHAR(256) NULL 
	,FundShortName VARCHAR(10) NULL 
	,Subscriptions MONEY NULL
	,SubscriptionsDisplay VARCHAR(256) NULL
	,Redemptions MONEY NULL
	,RedemptionsDisplay VARCHAR(256) NULL
	,Total MONEY NULL
	,TotalDisplay VARCHAR(256) NULL
	,LastUpdatedDate DATETIME NULL
)

AS
BEGIN
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[ufn_EDMDIPsGetDIPsBreakdown]
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
-- R Carter 19/10/2016 Update for WIMOFF Northern Trust Nominees
-- D Bacchus, R Dixon  23/03/2016  Based on the analysis in [Reporting].[usp_EDMDIPsGetDIPsBreakdown_RD], this update is to seperate the funds by inluding Fund Short Name
-- R Dixon	04/07/2017 Use confirmed data if available, otherwise use estimated data.
-------------------------------------------------------------------------------------- 

	
IF	@RunDate IS NULL
	SET	@RunDate = (SELECT MAX(valuation_point) from [dbo].[T_MASTER_DEALS_IN_PROGRESS]);



;WITH	CTE_Subs AS (
		SELECT	COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS [Agent_Name], MAP.TARGET_CODE AS FUND_SHORT_NAME, [Estimated?]
				,SUM(VALUE) AS Subscriptions
		FROM	[dbo].[T_MASTER_DEALS_IN_PROGRESS] DIP
		LEFT	OUTER JOIN [dbo].[T_REF_GENERAL_MAP] MAP
		ON		MAP.SOURCE_CODE = DIP.SUB_FUND
		AND		MAP.FIELD_NAME = 'Sub Fund'
		WHERE	[TYPE] IN ('Sale','Class Switch Sale') AND CONVERT(DATE, VALUATION_POINT) = @RunDate
		AND		MAIN_OWNER_NAME <> 'Northern Trust Nominees (Ireland) Ltd'
		GROUP	BY COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]), MAP.TARGET_CODE, [Estimated?]
), 
CTE_Reds AS (
		SELECT	COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS [Agent_Name], MAP.TARGET_CODE AS FUND_SHORT_NAME, [Estimated?]
				,SUM(VALUE) AS Redemptions
		FROM	[dbo].[T_MASTER_DEALS_IN_PROGRESS] DIP
		LEFT	OUTER JOIN [dbo].[T_REF_GENERAL_MAP] MAP
		ON		MAP.SOURCE_CODE = DIP.SUB_FUND
		AND		MAP.FIELD_NAME = 'Sub Fund'
		WHERE	[TYPE] IN ('Repurchase','Class Switch Repurchase') AND CONVERT(DATE, VALUATION_POINT) = @RunDate
		AND		MAIN_OWNER_NAME <> 'Northern Trust Nominees (Ireland) Ltd'
		GROUP	BY COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]), MAP.TARGET_CODE, [Estimated?]
),
CTE_Agents AS (
		SELECT	DISTINCT COALESCE([AGENT_NAME], [MAIN_OWNER_NAME]) AS  [AGENT_NAME], MAP.TARGET_CODE AS FUND_SHORT_NAME, DIP.CADIS_SYSTEM_UPDATED AS LASTUPDATEDDATE
		FROM	[dbo].[T_MASTER_DEALS_IN_PROGRESS] DIP
		LEFT	OUTER JOIN [dbo].[T_REF_GENERAL_MAP] MAP
		ON		MAP.SOURCE_CODE = DIP.SUB_FUND
		AND		MAP.FIELD_NAME = 'Sub Fund'
		WHERE	CONVERT(DATE, VALUATION_POINT) = @RunDate
		AND		MAIN_OWNER_NAME <> 'Northern Trust Nominees (Ireland) Ltd'
),
CTE_ESTIMATED AS (
		SELECT	FUND_SHORT_NAME, [ESTIMATED?]
		FROM	(SELECT	FUND_SHORT_NAME, [ESTIMATED?], ROW_NUMBER()  OVER (PARTITION BY FUND_SHORT_NAME ORDER BY [ESTIMATED?] ASC) AS ROWNUMBER
				FROM	(
						SELECT	DISTINCT MAP.TARGET_CODE AS FUND_SHORT_NAME, [ESTIMATED?]
						FROM	T_MASTER_DEALS_IN_PROGRESS DIP
						LEFT	OUTER JOIN [dbo].[T_REF_GENERAL_MAP] MAP
						ON		MAP.SOURCE_CODE = DIP.SUB_FUND
						AND		MAP.FIELD_NAME = 'Sub Fund'
						WHERE	CONVERT(DATE, VALUATION_POINT) = @RunDate
						) DEALS
				) DIPS
		WHERE	DIPS.ROWNUMBER = 1
)

INSERT	INTO @Output
		(AgentName
		,FundShortName
		,Subscriptions
		,SubscriptionsDisplay
		,Redemptions
		,RedemptionsDisplay
		,Total
		,TotalDisplay
		,LastUpdatedDate)
SELECT	a.[AGENT_NAME]
		, a.FUND_SHORT_NAME
		, ISNULL(s.Subscriptions,0) AS Subscriptions
		, PARSENAME(CONVERT(varchar, CONVERT(MONEY, ISNULL(s.Subscriptions,0)), 1),2) AS SubscriptionsDisplay
		, ISNULL(r.Redemptions,0)  *-1 AS Redemptions
		, PARSENAME(CONVERT(varchar, CONVERT(MONEY,  ISNULL(r.Redemptions,0) * -1), 1),2) AS RedemptionsDisplay
		, ISNULL(s.Subscriptions,0) + ISNULL(r.Redemptions,0) AS Total
		, PARSENAME(CONVERT(varchar, CONVERT(MONEY, ISNULL(s.Subscriptions,0) + ISNULL(r.Redemptions,0)), 1),2) AS TotalDisplay
		,LASTUPDATEDDATE
FROM	CTE_Agents a
INNER	JOIN CTE_Estimated e
ON		e.FUND_SHORT_NAME = a.FUND_SHORT_NAME
LEFT	OUTER JOIN CTE_Subs s ON s.[Agent_Name] = a.AGENT_NAME AND s.FUND_SHORT_NAME = a.FUND_SHORT_NAME AND s.[ESTIMATED?] =  e.[ESTIMATED?]
LEFT	OUTER JOIN CTE_Reds r ON r.[Agent_Name] = a.AGENT_NAME AND r.FUND_SHORT_NAME = a.FUND_SHORT_NAME AND r.[ESTIMATED?] =  e.[ESTIMATED?]
WHERE	a.[AGENT_NAME] IS NOT NULL
ORDER	BY ISNULL(s.Subscriptions,0) + ISNULL(r.Redemptions,0) DESC

RETURN

END
