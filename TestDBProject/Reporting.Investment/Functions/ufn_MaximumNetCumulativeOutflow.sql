
CREATE FUNCTION [Reporting.Investment].[ufn_MaximumNetCumulativeOutflow]
(
	@StartDate DATE = NULL
	,@EndDate DATE = NULL
)
RETURNS @Output TABLE (
      [Fund] VARCHAR(256) NULL
	  ,[Measure] VARCHAR(256) NULL
	  ,[Value] DECIMAL (19,5) NULL
	  ,[%ofAuM] DECIMAL (19,5) NULL
	  ,[FlowDate] DATE NULL
)

AS

--SELECT * FROM [Reporting.Investment].[ufn_Maximum_Net_Cumulative_Outflow](null,null)
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[ufn_Maximum_Net_Cumulative_Outflow]
-- 
-- Note:			
-- 
-- Author:			Leonard Maher
-- Date:			14/10/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 

-- 
-------------------------------------------------------------------------------------- 

BEGIN

IF @StartDate IS NULL
	SET @StartDate = dateadd(month,-6,getdate());
IF @EndDate IS NULL
	SET @EndDate = getdate();

DECLARE @AllFlows TABLE (Fund VARCHAR(256),RowNo INT, FlowDate Date, Value DECIMAL(19,5));
	
WITH CTE_FX AS (
	SELECT fx.[FXRATE_ID], [SPOT_RATE]
	FROM [dbo].[T_MASTER_FXRATE] fx
	INNER JOIN (
	SELECT [FXRATE_ID]
      ,MAX([DATE]) AS [DATE]
	  FROM [dbo].[T_MASTER_FXRATE]
	  WHERE [DATE] <= @EndDate
	  GROUP BY [FXRATE_ID]
  ) data ON data.[FXRATE_ID] = fx.[FXRATE_ID] AND data.[DATE] = fx.[DATE]
) INSERT INTO @Allflows
(
Fund
,RowNo
,FlowDate
,Value
)
	SELECT mff.[FUND_SHORT_NAME] AS [FUND_FLOW_NAME]
		  ,ROW_NUMBER() OVER (PARTITION BY mff.[FUND_SHORT_NAME] ORDER BY CONVERT(DATE,mff.[TRANSACTION_DATE]))
		  ,CONVERT(DATE,mff.[TRANSACTION_DATE]) AS [IN_FLOW_DATE]
		  ,SUM(mff.[MARKET_VALUE] * (CASE WHEN mff.CURRENCY = 'GBP' THEN 1 ELSE fx.[SPOT_RATE] END)) AS [VALUE]
	  FROM [dbo].[T_MASTER_FUND_FLOW] mff
	  INNER JOIN [dbo].[T_MASTER_FND] fnd
	  ON mff.FUND_SHORT_NAME = fnd.SHORT_NAME
	  LEFT JOIN CTE_FX fx ON mff.CURRENCY + 'GBP' = fx.FXRATE_ID
	  WHERE CONVERT(DATE,mff.[TRANSACTION_DATE]) > @StartDate
	  AND CONVERT(DATE,mff.[TRANSACTION_DATE]) < @EndDate
	  AND mff.FUND_FLOW_TYPE = 'NET'
	  AND mff.[FLOW_TYPE] = 'REDEMPTION'
	  GROUP BY
	  mff.[FUND_SHORT_NAME]
	  ,CONVERT(DATE,mff.[TRANSACTION_DATE]);

	;WITH CTE_5 AS
	(
	SELECT 
	a.Fund
	,RowNo
	,FlowDate
	,Value
	,sum(a.Value) over (PARTITION BY Fund order by RowNo rows 4 preceding) as cumulative5
	,sum(a.Value) over (PARTITION BY Fund order by RowNo rows 9 preceding) as cumulative10
	,sum(a.Value) over (PARTITION BY Fund order by RowNo rows 19 preceding) as cumulative20
   FROM @Allflows a
   ),CTE_AuM AS
   (
   SELECT
   MeasureDateId 
   ,KPIName
   ,MeasureValue
   ,AVG(MeasureValue) over (PARTITION BY KPIName order by MeasureDateId rows 4 preceding) as avg5
   ,AVG(MeasureValue) over (PARTITION BY KPIName order by MeasureDateId rows 9 preceding) as avg10
   ,AVG(MeasureValue) over (PARTITION BY KPIName order by MeasureDateId rows 19 preceding) as avg20
   FROM
   [Fact].[KPIFact] kf
	INNER JOIN [KPI].[MeasuredKPIs] mk ON kf.[KPIId] = mk.[KPIId]
	WHERE mk.[KPIName] LIKE '%- Daily AuM'
	)
	INSERT INTO @Output
	(
	   [Fund]
	  ,[Measure]
	  ,[Value]
	  ,[%ofAuM]
	  ,[FlowDate]
	)
	--------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
   SELECT
   Mc.Fund
   ,'1 Day' AS Measure
   ,Mc.Value
   ,CASE WHEN [MeasureValue] = 0 then 0 ELSE Mc.Value/[MeasureValue] END AS [% of AuM]
   ,CTE_5.FlowDate
   FROM
	   (
	   SELECT MAX(Value) as Value
	   ,Fund
	   FROM CTE_5
	   GROUP BY 
	   Fund
	   ) Mc INNER JOIN CTE_5 ON Mc.Value = CTE_5.Value
	   AND Mc.Fund = CTE_5.Fund
	LEFT JOIN CTE_AuM ON CONVERT(VARCHAR(8), CTE_5.FlowDate, 112) = CTE_AuM.[MeasureDateId]
	AND CTE_5.Fund + ' - Daily AuM' = CTE_AuM.[KPIName] 
	--------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
   UNION ALL 
   SELECT
   Mc.Fund
   ,'5 Days' AS Measure
   ,Mc.Value
   ,CASE WHEN [MeasureValue] = 0 then 0 ELSE Mc.Value/[avg5] END AS [% of AuM]
   ,CTE_5.FlowDate
   FROM
	   (
	   SELECT MAX(cumulative5) as Value
	   ,Fund
	   FROM CTE_5
	   GROUP BY 
	   Fund
	   ) Mc INNER JOIN CTE_5 ON Mc.Value = CTE_5.cumulative5
	   AND Mc.Fund = CTE_5.Fund
	LEFT JOIN CTE_AuM ON CONVERT(VARCHAR(8), CTE_5.FlowDate, 112) = CTE_AuM.[MeasureDateId]
	AND CTE_5.Fund + ' - Daily AuM' = CTE_AuM.[KPIName] 
	--------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
   UNION ALL
      SELECT
   Mc.Fund
   ,'10 Days' AS Measure
   ,Mc.Value
   ,CASE WHEN [MeasureValue] = 0 then 0 ELSE Mc.Value/[avg10] END AS [% of AuM]
   ,CTE_5.FlowDate
   FROM
	   (
	   SELECT MAX(cumulative10) as Value
	   ,Fund
	   FROM CTE_5
	   GROUP BY 
	   Fund
	   ) Mc INNER JOIN CTE_5 ON Mc.Value = CTE_5.cumulative10
	   AND Mc.Fund = CTE_5.Fund
	LEFT JOIN CTE_AuM ON CONVERT(VARCHAR(8), CTE_5.FlowDate, 112) = CTE_AuM.[MeasureDateId]
	AND CTE_5.Fund + ' - Daily AuM' = CTE_AuM.[KPIName] 
	--------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------
   UNION ALL
      SELECT
   Mc.Fund
   ,'20 Days' AS Measure
   ,Mc.Value
   ,CASE WHEN [MeasureValue] = 0 then 0 ELSE Mc.Value/[avg20] END AS [% of AuM]
   ,CTE_5.FlowDate
   FROM
	   (
	   SELECT MAX(cumulative20) as Value
	   ,Fund
	   FROM CTE_5
	   GROUP BY 
	   Fund
	   ) Mc INNER JOIN CTE_5 ON Mc.Value = CTE_5.cumulative20
	   AND Mc.Fund = CTE_5.Fund
	LEFT JOIN CTE_AuM ON CONVERT(VARCHAR(8), CTE_5.FlowDate, 112) = CTE_AuM.[MeasureDateId]
	AND CTE_5.Fund + ' - Daily AuM' = CTE_AuM.[KPIName];


	RETURN
   
END

