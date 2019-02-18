
CREATE FUNCTION [Reporting.Investment].[ufn_GetCumulativeNetOutflowWithOwner]
(
@Days INT
,@Date DATE
)
-- SELECT DISTINCT TOP(5) Lookup, RunDate, Agent, MainOwner, Cumu FROM [Reporting.Investment].[ufn_GetCumulativeNetOutflowWithOwner](20,'2016-06-20') ORDER BY Cumu

RETURNS @output TABLE
(
	Lookup VARCHAR(256) NULL,
	RowNo INT NULL,
	RunDate Date NULL,
	Agent VARCHAR(256) NULL,
	MainOwner VARCHAR(1000) NULL,
	Value DECIMAL(19,5) NULL,
	Cumu DECIMAL(19,5) NULL
)
AS
BEGIN
	;WITH CTE_Dates AS
	(
	SELECT
		ROW_NUMBER() OVER (ORDER BY CONVERT(DATE, VALUATION_POINT) DESC) AS RowNo
		,CONVERT(DATE, VALUATION_POINT) AS RedDate
		FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
		WHERE CONVERT(DATE, VALUATION_POINT) <= @Date
		GROUP BY CONVERT(DATE, VALUATION_POINT)
	)
	,CTE_Subs AS 
	(
	SELECT 
	  CONVERT(DATE, VALUATION_POINT) AS RunDate
	  ,COALESCE([AGENT_NAME], 'Unknown') AS Agent_Name
	  ,MAIN_OWNER_NAME
      ,SUM(VALUE) AS Subscriptions
	  FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS] a INNER JOIN 
	  CTE_Dates b ON CONVERT(DATE, a.VALUATION_POINT) = b.RedDate
	  WHERE [TYPE] = 'Sale'
	  AND b.RowNo <= @Days
	  GROUP BY 
	  COALESCE([AGENT_NAME], 'Unknown'), CONVERT(DATE, VALUATION_POINT)
	  ,MAIN_OWNER_NAME
	), CTE_Reds AS 
	(
	SELECT
		CONVERT(DATE, VALUATION_POINT) AS RunDate
		,COALESCE([AGENT_NAME], 'Unknown') AS [Agent_Name]
		,MAIN_OWNER_NAME
		,SUM(VALUE) AS Redemptions
	FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS] a INNER JOIN 
	  CTE_Dates b ON CONVERT(DATE, a.VALUATION_POINT) = b.RedDate
		WHERE [TYPE] = 'Repurchase'
		AND b.RowNo <= @Days
		GROUP BY 
		COALESCE([AGENT_NAME], 'Unknown')
		, CONVERT(DATE, VALUATION_POINT)
		,MAIN_OWNER_NAME
	  ), CTE_Total AS
	(
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY r.[AGENT_NAME] ORDER BY r.RunDate DESC) AS RowNo
		,sum(COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0)) over (Partition by r.[AGENT_NAME] order by r.AGENT_NAME) as cumulative
		,r.[AGENT_NAME] AS Agent
		,r.MAIN_OWNER_NAME AS MainOwner
		,COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0) AS Total
		FROM 
		CTE_Reds r
		Left JOIN
		CTE_Subs s ON r.AGENT_NAME = s.[Agent_Name]
		AND r.RunDate = s.RunDate
		AND r.MAIN_OWNER_NAME = s.MAIN_OWNER_NAME
		WHERE r.AGENT_NAME IS NOT NULL
		AND (COALESCE(s.Subscriptions,0) + COALESCE(r.Redemptions,0)) < 0
	) 
	INSERT INTO @output
	(
	Lookup,
	RowNo,
	RunDate,
	Agent,
	MainOwner,
	Value,
	Cumu
	)
	-----------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------------------------------------
	SELECT * FROM
	(
	SELECT 
	CONVERT(VARCHAR(100),@Days) + ' day(s) net ouflow' AS Lookup
	,'' as RowID
	,@Date as RunDate
	,Agent
	,MainOwner
	,SUM(Total) AS Total
	,CONVERT(DECIMAL(19,5),cumulative) AS cumulative
	FROM
	CTE_Total
	GROUP BY 
	Agent
	,MainOwner
	,CONVERT(DECIMAL(19,5),cumulative)
	) a
	Order by cumulative DESC

	UPDATE a
	SET MainOwner = stuff((SELECT ', '+ [MainOwner] FROM @output WHERE Agent = t.Agent FOR XML PATH('')),1,1,'') 
	FROM (SELECT DISTINCT Agent, MainOwner FROM @output ) t, @output a
	WHERE a.Agent = t.Agent 

	RETURN
END

