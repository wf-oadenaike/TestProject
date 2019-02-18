CREATE PROCEDURE [Fact].[usp_MergeKPIFact_BBGRisk_olu]
--DECLARE	@KPINAME VARCHAR(100) 
AS

---------------------------------------------------------------------------------------- 
---- Name:			[Fact].[usp_MergeKPIFact_BBGRisk_2.0]
---- 
---- Note:			
---- 
---- Author:			Joe Tapper
---- Date:			13/6/2017
---------------------------------------------------------------------------------------- 
---- History:			Initial Write 
---- New Version to take KPI Name as parameter to improve stability
---- 
---------------------------------------------------------------------------------------- 


-- Create Table Variable
DECLARE  @RiskTemp TABLE(
	[MeasureDateId] [NVARCHAR](8) NULL,
	[KPIId] [SMALLINT] NOT NULL,
	[MeasureValue] [NUMERIC](19, 5) NULL,
	[LastUpdatedDatetime] [DATETIME] NOT NULL,
	[ControlId] [VARCHAR](8000) NULL,
	[kpiname] [VARCHAR](128) NOT NULL
) 

Begin Try

 

	Set NoCount on;

	BEGIN TRANSACTION

	Declare	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_MergeKPIFact_BBGRisk_Olu]';	

		Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint 
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		, @SourceSystemId int = (SELECT COALESCE(SourceSystemId,-1) FROM [Audit].[SourceSystems] WHERE [SourceSystemCode] = 'BBG')
		;



--Insert Union Data from Staging Table  to Table Variable
--- Performance since inception ---
INSERT INTO @RiskTemp
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	 AS [MeasureDateId]
	,[KPIId] 

	, CASE WHEN  TRY_PARSE(coalesce([ContributiontoReturnPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),[ContributiontoReturnPort]))
	  ELSE
	  0
	  END  AS [MeasureValue]

	--,COALESCE(CONVERT(DECIMAL(19,5),[ContributiontoReturnPort]),0) AS [MeasureValue]
	,getdate() AS [LastUpdatedDatetime]
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','') AS [ControlId]
	,kpiname
	  FROM[dbo].[T_BBG_RISK_MONITORING_IN_ATTRIBUTION] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - Performance since inception'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Attribution - Main View'

--- Performance since inception vs benchmark ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE(a.[FileName]),CHARINDEX('_',REVERSE(a.[FileName]))-8,8))
	,b.[KPIId]
	--,CASE WHEN SUBSTRING(a.Fund,1,3) = 'SJP' THEN CASE WHEN COALESCE(CONVERT(DECIMAL(19,5),c.[ContributiontoReturn]),0) = 0 THEN 0 ELSE
	--((COALESCE(CONVERT(DECIMAL(19,5),a.[ContributiontoReturnPort]),0)/COALESCE(CONVERT(DECIMAL(19,5),c.[ContributiontoReturn]),0)) - 1) * 100 END
	--WHEN SUBSTRING(a.Fund,1,3) = 'ALL' THEN CASE WHEN COALESCE(CONVERT(DECIMAL(19,5),c.[ContributiontoReturn]),0) = 0 THEN 0 ELSE
	--((COALESCE(CONVERT(DECIMAL(19,5),a.[ContributiontoReturnPort]),0)/COALESCE(CONVERT(DECIMAL(19,5),c.[ContributiontoReturn]),0)) - 1) * 100 END
	--ELSE COALESCE(CONVERT(DECIMAL(19,5),a.[ContributiontoReturn]),0) END

,CASE WHEN SUBSTRING(a.Fund,1,3) = 'SJP' THEN CASE WHEN 
	  CASE WHEN  TRY_PARSE(coalesce(c.[ContributiontoReturn],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),c.[ContributiontoReturn]))
	  ELSE
	  coalesce(c.[ContributiontoReturn],'0')
	  END = 0 THEN 0 ELSE
	((CASE WHEN  TRY_PARSE(coalesce(a.[ContributiontoReturnPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),a.[ContributiontoReturnPort]))
	  ELSE
	  coalesce(a.[ContributiontoReturnPort],'0')
	  END)/ CASE WHEN  TRY_PARSE(coalesce(c.[ContributiontoReturn],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),c.[ContributiontoReturn]))
	  ELSE
	  coalesce(c.[ContributiontoReturn],'0')
	  END - 1) * 100 END
	WHEN SUBSTRING(a.Fund,1,3) = 'ALL' THEN CASE WHEN  CASE WHEN  TRY_PARSE(coalesce(c.[ContributiontoReturn],'0')as decimal(19,5)) IS NULL THEN 
	  convert(numeric(19,5),convert(float(53),c.[ContributiontoReturn]))
	  ELSE
	  coalesce(c.[ContributiontoReturn],'0')
	  END = 0 THEN 0 ELSE
	(( CASE WHEN  TRY_PARSE(coalesce(a.[ContributiontoReturnPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),a.[ContributiontoReturnPort]))
	  ELSE
	  coalesce(a.[ContributiontoReturnPort],'0')
	  END)/ CASE WHEN  TRY_PARSE(coalesce(c.[ContributiontoReturn],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),c.[ContributiontoReturn]))
	  ELSE
	  coalesce(c.[ContributiontoReturn],'0')
	  END - 1) * 100 END
	ELSE 	 CASE WHEN  TRY_PARSE(coalesce(a.[ContributiontoReturn],'0')as decimal(19,5)) IS NOT NULL THEN 
	  convert(numeric(19,5),convert(float(53),a.[ContributiontoReturn]))
	  ELSE
	  coalesce(a.[ContributiontoReturn],'0')
	  END END
	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM[dbo].[T_BBG_RISK_MONITORING_IN_ATTRIBUTION] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN a.[Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE a.[Fund] END +  ' - Performance since inception vs benchmark'
	  LEFT JOIN
	  (SELECT * FROM[dbo].[T_BBG_RISK_MONITORING_IN_ATTRIBUTION] WHERE [Fund] = 'WIMEIF') c ON 
	  -- SUBSTRING(a.[FileName],CHARINDEX('_',a.[FileName])+1,8) = SUBSTRING(c.[FileName],CHARINDEX('_',c.[FileName])+1,8)
	  -- and

	   REverse(SUBSTRING(REVERSE(a.[FileName]),CHARINDEX('_',REVERSE(a.[FileName]))-8,8)) = REverse(SUBSTRING(REVERSE(c.[FileName]),CHARINDEX('_',REVERSE(c.[FileName]))-8,8))
	  WHERE  a.[Fund] is not null
	  AND a.[Fund] <> 'Attribution - Main View'

--- Max drawdown on a 1-year view ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[MaxDrawPort]),0)
    ,CASE WHEN  TRY_PARSE(coalesce([MaxDrawPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[MaxDrawPort]))
	 ELSE
	 coalesce([MaxDrawPort],'0')
	 END
	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_PERFORMANCE] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END +  ' - Max drawdown on a 1-year view'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Performance - Main View'

--- Max drawdown on a 1-year view vs benchmark ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[MaxDrawPort])-CONVERT(DECIMAL(19,5),[MaxDrawBench]),0)

	,CASE WHEN  TRY_PARSE(coalesce([MaxDrawPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[MaxDrawPort]))
	 ELSE
	 coalesce([MaxDrawPort],'0')
	 END- 
	 CASE WHEN  TRY_PARSE(coalesce([MaxDrawBench],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[MaxDrawBench]))
	 ELSE
	 coalesce([MaxDrawBench],'0')
	 END

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_PERFORMANCE] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - Max drawdown on a 1-year view vs benchmark'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Performance - Main View'

--- Dividend yield vs benchmark ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CASE WHEN CONVERT(DECIMAL(19,5),[DivYldBench]) = 0 THEN 0 ELSE CONVERT(DECIMAL(19,5),[DivYldPort])/CONVERT(DECIMAL(19,5),[DivYldBench]) END,0)

	,case when 
	 CASE WHEN  TRY_PARSE(coalesce([DivYldBench],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[DivYldBench]))
	 ELSE
	 coalesce([DivYldBench],'0')
	 END=0 then 0
	 else
	 CASE WHEN  TRY_PARSE(coalesce([DivYldPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[DivYldPort]))
	 ELSE
	 coalesce([DivYldPort],'0')
	 END/ 
	  CASE WHEN  TRY_PARSE(coalesce([DivYldBench],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[DivYldBench]))
	 ELSE
	 coalesce([DivYldBench],'0')
	 END

	 END
	 
	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_CHARACTERISTICS] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - Dividend yield vs benchmark'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Characteristics - Main View'

--- Dividend yield ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[DivYldPort]),0)

	,CASE WHEN  TRY_PARSE(coalesce([DivYldPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	convert(numeric(19,5),convert(float(53),[DivYldPort]))
	ELSE
	coalesce([DivYldPort],'0')
	END

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_CHARACTERISTICS] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - Dividend yield'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Characteristics - Main View'

--- Tracking error ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[TrackErrPort]),0)

	 ,CASE WHEN  TRY_PARSE(coalesce([TrackErrPort],'0')as decimal(19,5)) IS NOT NULL THEN 
	 convert(numeric(19,5),convert(float(53),[TrackErrPort]))
	 ELSE
	 coalesce([TrackErrPort],'0')
	 END

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_PERFORMANCE] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - Tracking error'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Performance - Main View'

--- 3-month portfolio standard deviation % Bench ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CASE WHEN CONVERT(DECIMAL(19,5),[StdDevBench]) = 0 THEN 0 ELSE CONVERT(DECIMAL(19,5),[StdDevPort])/CONVERT(DECIMAL(19,5),[StdDevBench]) END,0)
	
	,CASE WHEN 
		CASE WHEN  TRY_PARSE(coalesce([TrackErrPort],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[TrackErrPort]))
		ELSE
		coalesce([TrackErrPort],'0')
		END=0 THEN 0 ELSE
		CASE WHEN  TRY_PARSE(coalesce([StdDevPort],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[StdDevPort]))
		ELSE
		coalesce([StdDevPort],'0')
		END / 

		CASE WHEN  TRY_PARSE(coalesce([StdDevBench],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[StdDevBench]))
		ELSE
		coalesce([StdDevBench],'0')
		END
    END


	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_PERFORMANCE] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - 3-month portfolio standard deviation'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Performance - Main View'

--- P/E vs benchmark ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CASE WHEN CONVERT(DECIMAL(19,5),[BEstP_BPort]) = 0 THEN 0 ELSE CONVERT(DECIMAL(19,5),[BEstP_EBench])/CONVERT(DECIMAL(19,5),[BEstP_BPort]) END,0)


	,CASE WHEN 
		CASE WHEN  TRY_PARSE(coalesce([BEstP_BPort],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[BEstP_BPort]))
		ELSE
		coalesce([BEstP_BPort],'0')
		END=0 THEN 0 ELSE
		CASE WHEN  TRY_PARSE(coalesce([BEstP_EBench],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[BEstP_EBench]))
		ELSE
		coalesce([BEstP_EBench],'0')
		END / 

		CASE WHEN  TRY_PARSE(coalesce([BEstP_BPort],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[BEstP_BPort]))
		ELSE
		coalesce([BEstP_BPort],'0')
		END
    END

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_CHARACTERISTICS] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - P/E vs benchmark'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Characteristics - Main View'

--- Realisable in 20 days ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile0_1])+CONVERT(DECIMAL(19,5),[LiquidityProfile1_5])+CONVERT(DECIMAL(19,5),[LiquidityProfile5_20]),0)

	,CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile0_1],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile0_1]))
		ELSE
		coalesce([LiquidityProfile0_1],'0')
		END +
	CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile1_5],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile1_5]))
		ELSE
		coalesce([LiquidityProfile1_5],'0')
		END +
	CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile5_20],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile5_20]))
		ELSE
		coalesce([LiquidityProfile5_20],'0')
		END
	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - Realisable in 20 days'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'

--- Max drawdown recovery vs benchmark recovery ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[RecPerMaxDrawPort])-CONVERT(DECIMAL(19,5),[RecPerMaxDrawBench]),0)

	,CASE WHEN  TRY_PARSE(coalesce(RecPerMaxDrawPort,'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),RecPerMaxDrawPort))
		ELSE
		coalesce(RecPerMaxDrawPort,'0')
		END 
	-
	CASE WHEN  TRY_PARSE(coalesce(RecPerMaxDrawBench,'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),RecPerMaxDrawBench))
		ELSE
		coalesce(RecPerMaxDrawBench,'0')
		END 
	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_PERFORMANCE] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - MD recovery vs benchmark recovery'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Performance - Main View'
--- LiquidityProfile0_1 ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile0_1]),0)

	,CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile0_1],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile0_1]))
		ELSE
		coalesce([LiquidityProfile0_1],'0')
		END 

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - LiquidityProfile0_1'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'
--- LiquidityProfile1_5 ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile1_5]),0)

	,CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile1_5],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile1_5]))
		ELSE
		coalesce([LiquidityProfile1_5],'0')
		END 

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - LiquidityProfile1_5'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'
--- LiquidityProfile5_20 ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile5_20]),0)

	,CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile5_20],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile5_20]))
		ELSE
		coalesce([LiquidityProfile5_20],'0')
		END 

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - LiquidityProfile5_20'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'
--- LiquidityProfile20_100 ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile20_100]),0)
	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - LiquidityProfile20_100'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'
--- LiquidityProfile100_250 ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile100_250]),0)

	,CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile100_250],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile100_250]))
		ELSE
		coalesce([LiquidityProfile100_250],'0')
		END 

	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - LiquidityProfile100_250'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'
--- LiquidityProfile_250 ---
UNION ALL
	SELECT 
	REverse(SUBSTRING(REVERSE([FileName]),CHARINDEX('_',REVERSE([FileName]))-8,8))
	,[KPIId]
	--,COALESCE(CONVERT(DECIMAL(19,5),[LiquidityProfile_250]),0)

	,CASE WHEN  TRY_PARSE(coalesce([LiquidityProfile_250],'0')as decimal(19,5)) IS NOT NULL THEN 
		convert(numeric(19,5),convert(float(53),[LiquidityProfile_250]))
		ELSE
		coalesce([LiquidityProfile_250],'0')
		END 



	,getdate()
	,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
	,kpiname
	  FROM [dbo].[T_BBG_RISK_MONITORING_IN_LIQUIDITY] a 
	  INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = CASE WHEN [Fund] = 'ALL_LIVE' THEN 'Firm-Wide' ELSE [Fund] END + ' - LiquidityProfile_250'
	  WHERE  [Fund] is not null
	  AND [Fund] <> 'Detailed View (% Part: 20)'




MERGE INTO [Fact].[KPIFact_olu] Tar
	USING (	SELECT MeasureDateId,
                     R.KPIId,
                     MeasureValue,
                     LastUpdatedDatetime,
                     ControlId,
                     TR.kpiname AS REFKPINAME,
					 R.kpiname
					 FROM @RiskTemp R
	LEFT	JOIN  dbo.T_REF_BBG_RISK_KPI_NAME TR 
	ON TR.KPIID = R.KPIId

) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId)
	--AND Src.kpiname= TR.kpiname)
	WHEN NOT MATCHED and Src.KPIname = src.REFKPINAME
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [LastUpdatedDatetime], [ControlId], [SourceSystemId])
				VALUES (Src.[MeasureDateId], Src.[KPIId], ISNULL(Src.[MeasureValue],0), Src.[LastUpdatedDatetime], Src.[ControlId], @SourceSystemId)
				
    WHEN MATCHED AND Tar.MeasureValue <> Src.MeasureValue and Tar.KPIID=Src.KPIID
		THEN UPDATE SET 
					 Tar.MeasureValue = Src.MeasureValue
					,Tar.ControlId = Src.[ControlId]
					,Tar.LastUpdatedDatetime = Src.[LastUpdatedDatetime];
			SET @InsertRowCount = @@ROWCOUNT		
			SET @UpdateRowCount = @@ROWCOUNT			


	SELECT		 @ProcessRowCount AS ProcessRowCount
				, @InsertRowCount AS InsertRowCount
				, @UpdateRowCount AS UpdateRowCount
				, @DeleteRowCount AS DeleteRowCount
	;



	COMMIT;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		ROLLBACK;
		 
		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH
