
CREATE FUNCTION [Reporting.Investment].[ufn_GetCumulativeNetOutflow]
(
)
RETURNS @output TABLE
(
	Lookup VARCHAR(256) NULL,
	RowNo INT NULL,
	RunDate Date NULL,
	Agent VARCHAR(256) NULL,
	Value DECIMAL(19,5) NULL
)
AS
BEGIN
	;WITH CTE_Subs AS (SELECT
	  CONVERT(DATE, VALUATION_POINT) AS RunDate
	  ,COALESCE([AGENT_NAME], 'Unknown') AS [Agent_Name]
      ,SUM(VALUE) AS Subscriptions
  FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
  WHERE [TYPE] = 'Sale'
  GROUP BY COALESCE([AGENT_NAME], 'Unknown'), CONVERT(DATE, VALUATION_POINT)
	), CTE_Reds AS (
	SELECT
		CONVERT(DATE, VALUATION_POINT) AS RunDate
		,COALESCE([AGENT_NAME], 'Unknown') AS [Agent_Name]
		,SUM(VALUE) AS Redemptions
	FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
	WHERE [TYPE] = 'Repurchase'
	GROUP BY COALESCE([AGENT_NAME], 'Unknown'), CONVERT(DATE, VALUATION_POINT)
  ), CTE_Total AS
  (
  SELECT 
    
	--sum(COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0)) over (order by r.RunDate rows 4 preceding) as cumulative5
	ROW_NUMBER() OVER (PARTITION BY r.RunDate ORDER BY COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0)) AS RowNo
	,DENSE_RANK() over (order by r.RunDate) as RankNo
	,r.RunDate
	,r.[AGENT_NAME] AS Agent
	,COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0) AS Total
FROM 
	CTE_Reds r
	Left JOIN
	CTE_Subs s ON r.AGENT_NAME = s.[Agent_Name]
	AND r.RunDate = s.RunDate
WHERE r.AGENT_NAME IS NOT NULL
AND (COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0)) < 0
) 
	INSERT INTO @output
	(
	Lookup,
	RowNo,
	RunDate,
	Agent,
	Value
	)
	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	SELECT '1-day net ouflow'+CONVERT(VARCHAR,RowNo)+convert(varchar(8),RunDate,112) AS Lookup
	,RowNo
	,RunDate
	,Agent
	,Total
	FROM
	CTE_Total
	WHERE RowNo < 6
	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	UNION ALL

	SELECT 
	'5-day cumulative net outflow'+CONVERT(VARCHAR,Row_Number() over (Partition by a.RunDate order by Total))+convert(varchar(8),RunDate,112) AS Lookup
	,Row_Number() over (Partition by a.RunDate order by Total) RowNo
	,a.RunDate
	,a.Agent
	,Total
	FROM
	(
	SELECT 
	a.Agent
	,a.RunDate
	,SUM(b.Total) AS Total


	FROM
	CTE_Total a
	LEFT JOIN 
	CTE_Total b ON a.RankNo >= b.RankNo 
	AND a.RankNo - 4 <= b.RankNo 
	AND a.Agent = b.Agent
	GROUP BY
	a.Agent
	,a.RunDate
	) a
	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	UNION ALL
	SELECT 
	'10-day cumulative net outflow'+CONVERT(VARCHAR,Row_Number() over (Partition by a.RunDate order by Total))+convert(varchar(8),RunDate,112) AS Lookup
	,Row_Number() over (Partition by a.RunDate order by Total) RowNo
	,a.RunDate
	,a.Agent
	,Total
	FROM
	(
	SELECT 
	a.Agent
	,a.RunDate
	,SUM(b.Total) AS Total


	FROM
	CTE_Total a
	LEFT JOIN 
	CTE_Total b ON a.RankNo >= b.RankNo 
	AND a.RankNo - 9 <= b.RankNo 
	AND a.Agent = b.Agent
	GROUP BY
	a.Agent
	,a.RunDate
	) a

	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	UNION ALL
	SELECT 
	'20-day cumulative net outflow'+CONVERT(VARCHAR,Row_Number() over (Partition by a.RunDate order by Total))+convert(varchar(8),RunDate,112) AS Lookup
	,Row_Number() over (Partition by a.RunDate order by Total) RowNo
	,a.RunDate
	,a.Agent
	,Total
	FROM
	(
	SELECT 
	a.Agent
	,a.RunDate
	,SUM(b.Total) AS Total

	FROM
	CTE_Total a
	LEFT JOIN 
	CTE_Total b ON a.RankNo >= b.RankNo 
	AND a.RankNo - 19 <= b.RankNo 
	AND a.Agent = b.Agent
	GROUP BY
	a.Agent
	,a.RunDate
	) a

	RETURN
END

