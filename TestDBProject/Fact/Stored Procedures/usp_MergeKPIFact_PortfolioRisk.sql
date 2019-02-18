CREATE PROCEDURE [Fact].[usp_MergeKPIFact_PortfolioRisk]

@PositionDate Date = null
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Fact].[usp_MergeKPIFact_PortfolioRisk]
-- 
-- Note:			
-- 
-- Author:			L Maher
-- Date:			7/10/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 

-- Date:			18/10/2016
-- Not to include cash
-- Date:				28/6/2017
-- Author:			Joe Tapper
-- Corrected Date to get Fridays data on following Monday
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on;

	

	--DECLARE @PositionDate as date
	Declare @Cte_Row_count bigint =0;
	Declare	@strProcedureName		VARCHAR(100)	= '[Fact].[usp_MergeKPIFact_PortfolioRisk]';	

		Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		, @SourceSystemId int = (SELECT COALESCE(SourceSystemId,-1) FROM [Audit].[SourceSystems] WHERE [SourceSystemCode] = 'WIM')
		;

		IF @PositionDate IS NULL
		BEGIN
			SET @PositionDate = getdate()
		END



		SET @PositionDate= CONVERT(VARCHAR(10), DATEADD(DAY, CASE DATENAME(WEEKDAY, @PositionDate) 
                        WHEN 'Sunday' THEN -2 
                        WHEN 'Monday' THEN -3 
                        ELSE -1 END, DATEDIFF(DAY, 0, @PositionDate)),120)




	DECLARE @Inflows TABLE (
	[FUND_SHORT_NAME] VARCHAR(256) NULL,
	[FUND_LONG_NAME] VARCHAR(256) NULL,
	[FLOW_TYPE] VARCHAR(15) NULL,
	[FUND_FLOW_TYPE] VARCHAR(15) NULL,
	[IN_FLOW_DATE] VARCHAR(256) NULL,
	[VALUE] DECIMAL(18,2) NULL,
	[LastUpdatedDate] DATETIME NULL
	)

	INSERT INTO @Inflows
	EXEC [Reporting.Investment].[usp_GetInFlows] @PositionDate
;WITH CTE_Sector AS 
(
		SELECT
			FUND_SHORT_NAME
			,COALESCE(s1.Sector, s.Sector, tms.[BBG_SECTOR]) AS Sector
			,CONVERT(DECIMAL(19,5),MARKET_VALUE_BASE) AS MARKET_VALUE_BASE
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv
		LEFT JOIN [dbo].[T_MASTER_SEC] tms ON tms.EDM_SEC_ID = mv.EDM_SEC_ID
		LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = mv.[UNIQUE_BLOOMBERG_ID]
		LEFT JOIN [Organisation].[UnquotedCompanies] uc ON us.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Core].[Sectors] s ON ucai.SectorId = s.SectorId

		LEFT JOIN [unquoted].[ListedSecurities] ls ON ls.UniqueBloombergId = mv.UNIQUE_BLOOMBERG_ID
		LEFT JOIN [unquoted].[ListedCompanies] lc ON ls.ListedCompanyId = lc.ListedCompanyId
		LEFT JOIN [Core].[Sectors] s1 ON lc.SectorId = s1.SectorId

		--UNION ALL

		--SELECT
		--	FUND_SHORT_NAME
		--	,'Cash'
		--	,VALUE
		--FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
		--WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
),
CTE_Maturity AS 
(
		SELECT
			FUND_SHORT_NAME
			,COALESCE(cmWPCT1.CompanyMaturity, cmWPCT.CompanyMaturity) AS CompanyMaturity
			,CONVERT(DECIMAL(19,5),MARKET_VALUE_BASE) AS MARKET_VALUE_BASE
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv
		LEFT JOIN [dbo].[T_MASTER_SEC] tms ON tms.EDM_SEC_ID = mv.EDM_SEC_ID
		LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = mv.[UNIQUE_BLOOMBERG_ID]
		LEFT JOIN [Organisation].[UnquotedCompanies] uc ON us.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId

		LEFT JOIN [unquoted].[ListedSecurities] ls ON ls.UniqueBloombergId = mv.UNIQUE_BLOOMBERG_ID
		LEFT JOIN [unquoted].[ListedCompanies] lc ON ls.ListedCompanyId = lc.ListedCompanyId
		LEFT JOIN [Core].[CompanyMaturities] cmWPCT ON ucai.WIMPCTCompanyMaturityId = cmWPCT.CompanyMaturityId
		LEFT JOIN [Core].[CompanyMaturities] cmWPCT1 ON lc.WIMPCTCompanyMaturityId = cmWPCT1.CompanyMaturityId

		--UNION ALL

		--SELECT
		--	FUND_SHORT_NAME
		--	,'Cash'
		--	,VALUE
		--FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
		--WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
),
CTE_Unquoted AS
(
		SELECT
			PRICE_DATE
			,FUND_SHORT_NAME
			,IsUnquoted
			,CONVERT(DECIMAL(19,5),MARKET_VALUE_BASE) AS MARKET_VALUE_BASE
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv

		--UNION ALL

		--SELECT
		--	LastUpdatedDate AS PriceDate
		--	,FUND_SHORT_NAME
		--	,0
		--	,VALUE
		--FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
		--WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
)

Select @Cte_Row_count=
(SELECT count(*)  from CTE_SECTOR) +  
(SELECT count(*)  from CTE_Maturity) + 
(SELECT count(*)  from CTE_Unquoted)

if(@Cte_Row_count>0 )
BEGIN
BEGIN TRANSACTION
;WITH CTE_Sector AS 
(
		SELECT
			FUND_SHORT_NAME
			,COALESCE(s1.Sector, s.Sector, tms.[BBG_SECTOR]) AS Sector
			,CONVERT(DECIMAL(19,5),MARKET_VALUE_BASE) AS MARKET_VALUE_BASE
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv
		LEFT JOIN [dbo].[T_MASTER_SEC] tms ON tms.EDM_SEC_ID = mv.EDM_SEC_ID
		LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = mv.[UNIQUE_BLOOMBERG_ID]
		LEFT JOIN [Organisation].[UnquotedCompanies] uc ON us.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Core].[Sectors] s ON ucai.SectorId = s.SectorId

		LEFT JOIN [unquoted].[ListedSecurities] ls ON ls.UniqueBloombergId = mv.UNIQUE_BLOOMBERG_ID
		LEFT JOIN [unquoted].[ListedCompanies] lc ON ls.ListedCompanyId = lc.ListedCompanyId
		LEFT JOIN [Core].[Sectors] s1 ON lc.SectorId = s1.SectorId

		--UNION ALL

		--SELECT
		--	FUND_SHORT_NAME
		--	,'Cash'
		--	,VALUE
		--FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
		--WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
),
CTE_Maturity AS 
(
		SELECT
			FUND_SHORT_NAME
			,COALESCE(cmWPCT1.CompanyMaturity, cmWPCT.CompanyMaturity) AS CompanyMaturity
			,CONVERT(DECIMAL(19,5),MARKET_VALUE_BASE) AS MARKET_VALUE_BASE
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv
		LEFT JOIN [dbo].[T_MASTER_SEC] tms ON tms.EDM_SEC_ID = mv.EDM_SEC_ID
		LEFT JOIN [Organisation].[UnquotedSecurities] us ON us.[BBGUniqueId/FOID] = mv.[UNIQUE_BLOOMBERG_ID]
		LEFT JOIN [Organisation].[UnquotedCompanies] uc ON us.UnquotedCompanyId = uc.UnquotedCompanyId
		LEFT JOIN [Organisation].[UnquotedCompanyAdditionalInfo] ucai ON ucai.UnquotedCompanyId = uc.UnquotedCompanyId

		LEFT JOIN [unquoted].[ListedSecurities] ls ON ls.UniqueBloombergId = mv.UNIQUE_BLOOMBERG_ID
		LEFT JOIN [unquoted].[ListedCompanies] lc ON ls.ListedCompanyId = lc.ListedCompanyId
		LEFT JOIN [Core].[CompanyMaturities] cmWPCT ON ucai.WIMPCTCompanyMaturityId = cmWPCT.CompanyMaturityId
		LEFT JOIN [Core].[CompanyMaturities] cmWPCT1 ON lc.WIMPCTCompanyMaturityId = cmWPCT1.CompanyMaturityId

		--UNION ALL

		--SELECT
		--	FUND_SHORT_NAME
		--	,'Cash'
		--	,VALUE
		--FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
		--WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
),
CTE_Unquoted AS
(
		SELECT
			PRICE_DATE
			,FUND_SHORT_NAME
			,IsUnquoted
			,CONVERT(DECIMAL(19,5),MARKET_VALUE_BASE) AS MARKET_VALUE_BASE
		FROM [Reporting.Investment].[ufn_GetFundHoldingsMarketValue] (@PositionDate) mv

		--UNION ALL

		--SELECT
		--	LastUpdatedDate AS PriceDate
		--	,FUND_SHORT_NAME
		--	,0
		--	,VALUE
		--FROM [Reporting.Investment].[ufn_GetAUMs] (@PositionDate)
		--WHERE Description NOT IN ('Portfolio Market Value') AND IsEstimate = 1
)
MERGE INTO [Fact].[KPIFact] Tar
	USING (
------------------------------------------------------------------------------------------------------------------------------------------------
-- exposure to any one sector -- 
-----------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
CONVERT(VARCHAR(8), @PositionDate, 112) AS [MeasureDateId]
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - exposure to any one sector')) AS [KPIId] 
,CASE WHEN COALESCE(SUM(MARKET_VALUE_BASE),0) = 0 THEN 0 ELSE MAX([MARKET_VALUE_BASE])/SUM(MARKET_VALUE_BASE) END  AS [MeasureValue]
,getdate()  AS [LastUpdatedDatetime]
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','') AS [ControlId]
FROM
(SELECT FUND_SHORT_NAME, Sector, SUM(MARKET_VALUE_BASE) AS MARKET_VALUE_BASE FROM CTE_Sector GROUP BY FUND_SHORT_NAME, Sector) a
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - exposure to any one sector'
GROUP BY CUBE(
b.[KPIId])
------------------------------------------------------------------------------------------------------------------------------------------------
-- exposure 'Mid to Large'  -- 
------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL SELECT 
CONVERT(VARCHAR(8), @PositionDate, 112)
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - mid-large cap stocks'))
,CASE WHEN COALESCE(SUM(MARKET_VALUE_BASE),0) = 0 THEN 0 ELSE SUM(CASE WHEN CompanyMaturity = 'Mid to Large' THEN [MARKET_VALUE_BASE] ELSE 0 END)/SUM(MARKET_VALUE_BASE) END AS [Mid-Large]
,getdate()
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
FROM
CTE_Maturity a
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - mid-large cap stocks'
GROUP BY CUBE(
b.[KPIId])
------------------------------------------------------------------------------------------------------------------------------------------------
-- exposure quoted early growth companies  -- 
------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL SELECT 
CONVERT(VARCHAR(8), @PositionDate, 112)
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - quoted early growth companies'))
,CASE WHEN COALESCE(SUM(MARKET_VALUE_BASE),0) = 0 THEN 0 ELSE SUM(CASE WHEN CompanyMaturity = 'Early Growth' THEN [MARKET_VALUE_BASE] ELSE 0 END)/SUM(MARKET_VALUE_BASE) END AS [EarlyGrowth]
,getdate()
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
FROM
CTE_Maturity a
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - quoted early growth companies'
GROUP BY CUBE(
b.[KPIId])
------------------------------------------------------------------------------------------------------------------------------------------------
-- quoted early stage companies  -- 
------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL SELECT 
CONVERT(VARCHAR(8), @PositionDate, 112)
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - quoted early stage companies'))
,CASE WHEN COALESCE(SUM(MARKET_VALUE_BASE),0) = 0 THEN 0 ELSE SUM(CASE WHEN CompanyMaturity = 'Early Stage' THEN [MARKET_VALUE_BASE] ELSE 0 END)/SUM(MARKET_VALUE_BASE) END AS [EarlyStage]
,getdate()
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
FROM
CTE_Maturity a
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - quoted early stage companies'
GROUP BY CUBE(
b.[KPIId])
------------------------------------------------------------------------------------------------------------------------------------------------
-- exposure to Unquoted stocks -- 
-----------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL SELECT
CONVERT(VARCHAR(8), @PositionDate, 112)
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - Unquoted stocks'))
,CASE WHEN COALESCE(SUM(MARKET_VALUE_BASE),0) = 0 THEN 0 ELSE SUM(CASE WHEN IsUnquoted = 1 THEN [MARKET_VALUE_BASE] ELSE 0 END)/SUM(MARKET_VALUE_BASE) END AS [Unquoted]
,getdate()
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
FROM CTE_Unquoted a
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - Unquoted stocks'
GROUP BY CUBE(
[KPIId])
------------------------------------------------------------------------------------------------------------------------------------------------
-- exposure to % Redemptions -- 
-----------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL SELECT
CONVERT(VARCHAR(8), @PositionDate, 112)
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - Redemptions (% AuM)'))
,CASE WHEN SUM(a.MARKET_VALUE_BASE) = 0 THEN 0 ELSE SUM(c.VALUE)/ SUM(a.MARKET_VALUE_BASE) END AS MeasureValue
,getdate()
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
FROM CTE_Unquoted a
LEFT JOIN @Inflows c
ON c.FUND_SHORT_NAME = a.FUND_SHORT_NAME
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - Redemptions (% AuM)'

WHERE c.FLOW_TYPE = 'REDEMPTION'
GROUP BY CUBE(
[KPIId])
------------------------------------------------------------------------------------------------------------------------------------------------
-- Daily AuM -- 
-----------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL SELECT
CONVERT(VARCHAR(8), @PositionDate, 112)
,COALESCE([KPIId],(SELECT [KPIId] FROM [KPI].[MeasuredKPIs] WHERE [KPIName] = 'Firm-Wide - Daily AuM'))
,SUM(a.MARKET_VALUE_BASE) AS MeasureValue
,getdate()
,convert(varchar(8),getdate(),112) + REPLACE(convert(varchar(8),getdate(),114),':','')
FROM CTE_Unquoted a
INNER JOIN [KPI].[MeasuredKPIs] b ON b.[KPIName] = a.[FUND_SHORT_NAME] + ' - Daily AuM'
GROUP BY CUBE(
[KPIId])
) Src
	ON (Tar.MeasureDateId = Src.MeasureDateId
	AND Tar.KPIId = Src.KPIId)
	WHEN NOT MATCHED
		THEN INSERT ([MeasureDateId], [KPIId], [MeasureValue], [LastUpdatedDatetime], [ControlId], [SourceSystemId])
				VALUES (Src.[MeasureDateId], Src.[KPIId], Src.[MeasureValue], Src.[LastUpdatedDatetime], Src.[ControlId], @SourceSystemId)
    WHEN MATCHED AND Tar.MeasureValue <> Src.MeasureValue
		THEN UPDATE SET 
					 Tar.MeasureValue = Src.MeasureValue
					,Tar.ControlId = Src.[ControlId]
					,Tar.LastUpdatedDatetime = Src.[LastUpdatedDatetime]
;

	SET @InsertRowCount = @@ROWCOUNT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

	COMMIT;
END
ELSE
BEGIN
SELECT  0 AS ProcessRowCount,
		0 AS InsertRowCount,
		0 AS UpdateRowCount,
		0 AS DeleteRowCount
		;
END;
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

