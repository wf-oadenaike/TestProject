

CREATE FUNCTION [Access.WebDev].[ufn_KPIGroups2]
(
	@RetrievalDate datetime = NULL
)
RETURNS @KPIResults TABLE (
	KPIGroupId smallint, 
	KPIGroupName varchar(128), 
	KPIID int, 
	KPIName varchar(256), 
	KPIDescription varchar(256), 
	IsPercentage BIT, 
	KPIValue decimal(19,5),
	OwnerRoleName nvarchar(128),
	PercentageOverThresholdRed decimal(19,5),
	PercentageOverThresholdAmber decimal(19,5),
	PercentageOverThresholdGreen decimal(19,5), 
	RedThresholdValue decimal(19,5),
	AmberThresholdValue decimal(19,5),
	GreenThresholdValue decimal(19,5),
	IsRed bit,
	IsAmber bit,
	IsGreen bit,
	FrequencyName nvarchar(128),
	LastUpdatedDate DATETIME,
	RiskCategory VARCHAR(256),
	RiskSubCategory VARCHAR(256),
	MaxLastUpdatedDate [datetime]
)
AS
BEGIN
	IF (@RetrievalDate IS NULL) BEGIN
			SELECT @RetrievalDate = GetDate()
		END;

		-- Table to store KPI filtered/aggregated KPI data
		DECLARE @KPIData AS TABLE (KPIID int, KPIValue decimal(19,5),
									RedThresholdValue decimal(19,5),
									AmberThresholdValue decimal(19,5), GreenThresholdValue decimal(19,5), Operator VARCHAR(1), LastUpdatedDate DATETIME);
	
		INSERT INTO @KPIData (KPIID, KPIValue,
								RedThresholdValue, AmberThresholdValue, GreenThresholdValue,
								Operator, LastUpdatedDate)
SELECT	mk.KPIID
		, ISNULL((CASE	WHEN mk.AggrFunction = 'SUM' THEN SUM(kf.MeasureValue) 
						WHEN mk.AggrFunction = 'AVG' THEN AVG(kf.MeasureValue) 
						WHEN mk.AggrFunction = 'LAT' THEN MAX(kl.MeasureValue)
						
						END),0) as KPIValue
		, mk.RedThresholdValue
		, mk.AmberThresholdValue		 
		, mk.GreenThresholdValue
		, mk.Operator
		, MAX(kf.LastUpdatedDatetime) AS LastUpdatedDatetime
FROM	[KPI].[MeasuredKPIs] mk
LEFT	JOIN [KPI].[RefreshFrequency] rf ON mk.RefreshFrequencyId = rf.RefreshFrequencyId
LEFT	JOIN 
		(

		SELECT	fac.KPIId, fac.MeasureDateId, fac.LastUpdatedDatetime, fac.MeasureValue 
				FROM	
				
				(
				
--				Select KPIId,MeasureDateId, LastUpdatedDatetime, MeasureValue  from [Fact].[KPIFact] f 
--where LastUpdatedDatetime=(select max(LastUpdatedDatetime) from [Fact].[KPIFact]  where MeasureDateId=f.MeasureDateId and KPIId=f.KPIId)

SELECT d.KPIId,ds.MeasureDateId, ds.LastUpdatedDatetime, ds.MeasureValue
FROM kpi.MeasuredKPIs AS d
cross apply [Core].[Calendar] cal 
CROSS APPLY
(
  SELECT TOP (1) MeasureDateId,LastUpdatedDatetime,MeasureValue
  FROM [Fact].[KPIFact]
  WHERE kpiid=d.kpiid  
  and MeasureDateId = cal.CalendarId
  ORDER BY LastUpdatedDatetime DESC
) AS ds
where cal.CalendarDate<=getdate()

)
							
				fac
				INNER	JOIN [Core].[Calendar] cal
				ON		fac.MeasureDateId = cal.CalendarId
				INNER	JOIN [KPI].[MeasuredKPIs] mkpi
				ON		fac.KPIId = mkpi.KPIId
				LEFT	JOIN [KPI].[RefreshFrequency] rf 
				ON		mkpi.RefreshFrequencyId = rf.RefreshFrequencyId
				WHERE	LastUpdatedDatetime < DATEADD(d, 1, @RetrievalDate)
				AND		convert(date,cal.CalendarDate) >= convert(date,DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate))
				and		mkpi.AggrFunction IN ('AVG', 'SUM')




		--SELECT * 
		--FROM	(
		--		SELECT	fac.KPIId, fac.MeasureDateId, fac.LastUpdatedDatetime, fac.MeasureValue, ROW_NUMBER() OVER (PARTITION BY fac.KPIId, MeasureDateId ORDER BY LastUpdatedDatetime DESC) AS ROWNUM
		--		FROM	[Fact].[KPIFact] fac
		--		INNER	JOIN [Core].[Calendar] cal
		--		ON		fac.MeasureDateId = cal.CalendarId
		--		INNER	JOIN [KPI].[MeasuredKPIs] mkpi
		--		ON		fac.KPIId = mkpi.KPIId
		--		LEFT	JOIN [KPI].[RefreshFrequency] rf 
		--		ON		mkpi.RefreshFrequencyId = rf.RefreshFrequencyId
		--		WHERE	LastUpdatedDatetime < DATEADD(d, 1, @RetrievalDate)
		--		AND		convert(date,cal.CalendarDate) >= convert(date,DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate))
		--		and		mkpi.AggrFunction IN ('AVG', 'SUM')
		--		) x 
		--WHERE	x.ROWNUM =1
		) kf
ON		kf.KPIId = mk.KPIId
LEFT	JOIN 
		(

			SELECT	fac.KPIId, fac.MeasureDateId, fac.LastUpdatedDatetime, fac.MeasureValue 
				FROM	
				
				(
				
				--Select KPIId,MeasureDateId, LastUpdatedDatetime, MeasureValue  from [Fact].[KPIFact] f 
--where LastUpdatedDatetime=(select max(LastUpdatedDatetime) from [Fact].[KPIFact]  where MeasureDateId=f.MeasureDateId and KPIId=f.KPIId)


SELECT d.KPIId,ds.MeasureDateId, ds.LastUpdatedDatetime, ds.MeasureValue
FROM kpi.MeasuredKPIs AS d
cross apply [Core].[Calendar] cal 
CROSS APPLY
(
  SELECT TOP (1) MeasureDateId,LastUpdatedDatetime,MeasureValue
  FROM [Fact].[KPIFact]
  WHERE kpiid=d.kpiid  
  and MeasureDateId = cal.CalendarId
  ORDER BY LastUpdatedDatetime DESC
) AS ds
where cal.CalendarDate<=getdate()

)
							
				fac
				INNER	JOIN [Core].[Calendar] cal
				ON		fac.MeasureDateId = cal.CalendarId
				INNER	JOIN [KPI].[MeasuredKPIs] mkpi
				ON		fac.KPIId = mkpi.KPIId
				LEFT	JOIN [KPI].[RefreshFrequency] rf 
				ON		mkpi.RefreshFrequencyId = rf.RefreshFrequencyId
				WHERE	LastUpdatedDatetime < DATEADD(d, 1, @RetrievalDate)
				AND		convert(date,cal.CalendarDate) >= convert(date,DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate))
				and		mkpi.AggrFunction ='LAT'






		--SELECT * 
		--FROM	(
		--		SELECT	fac.KPIId, fac.MeasureDateId, fac.LastUpdatedDatetime, fac.MeasureValue, ROW_NUMBER() OVER (PARTITION BY fac.KPIId ORDER BY fac.MeasureDateId  desc, fac.LastUpdatedDatetime desc) AS ROWNUM
		--		FROM	[Fact].[KPIFact] fac
		--		INNER	JOIN [Core].[Calendar] cal
		--		ON		fac.MeasureDateId = cal.CalendarId
		--		INNER	JOIN [KPI].[MeasuredKPIs] mkpi
		--		ON		fac.KPIId = mkpi.KPIId
		--		LEFT	JOIN [KPI].[RefreshFrequency] rf 
		--		ON		mkpi.RefreshFrequencyId = rf.RefreshFrequencyId
		--		WHERE	LastUpdatedDatetime < DATEADD(d, 1, @RetrievalDate)
		--		AND		convert(date,cal.CalendarDate) >= convert(date,DATEADD(Day, -1 * rf.DaysRange, @RetrievalDate))
		--		and		mkpi.AggrFunction = 'LAT'
		--		) y
		--WHERE	y.ROWNUM =1
		) kl
ON		kl.KPIId = mk.KPIId
		GROUP	BY
			 mk.KPIID
			 , mk.RedThresholdValue
			 , mk.AmberThresholdValue		 
			 , mk.GreenThresholdValue
			 , mk.Operator
			 , mk.AggrFunction
		 
		;WITH CTE_LastUpdatedDate (KPIId, KPILastUpdated, GreenThresholdValue, AmberThresholdValue, RedThresholdValue, Operator) AS
		(
			SELECT f.KPIId, MAX(LastUpdatedDatetime), GreenThresholdValue, AmberThresholdValue, RedThresholdValue, Operator  FROM [Fact].[KPIFact] f INNER JOIN [KPI].[MeasuredKPIs] mk ON mk.KPIID = f.KPIID
			GROUP BY f.KPIId, GreenThresholdValue, AmberThresholdValue, RedThresholdValue, Operator
		)
		INSERT INTO @KPIResults (KPIGroupId, KPIGroupName, KPIID, KPIName, KPIDescription, IsPercentage, KPIValue, OwnerRoleName, PercentageOverThresholdRed,
								 PercentageOverThresholdAmber, PercentageOverThresholdGreen, RedThresholdValue, AmberThresholdValue, GreenThresholdValue,
								 IsRed, IsAmber, IsGreen, FrequencyName, LastUpdatedDate, RiskCategory, RiskSubCategory, MaxLastUpdatedDate ) 
		SELECT kg.KPIGroupId
			 , kg.KPIGroupName
			 , mk.KPIID 
			 , mk.KPINameAlias AS KPIName
			 , mk.KPIDescription
			 , mk.IsPercentage
			 , ISNULL(d.KPIValue, 0) AS KPIValue
			 , r.RoleName AS [OwnerRoleName]
			 , 
				   CASE 
					WHEN cte.RedThresholdValue < cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) > cte.RedThresholdValue THEN 0 -- NOT RED
												ELSE (cte.RedThresholdValue - ISNULL(d.KPIValue, 0))/(CASE WHEN cte.RedThresholdValue = 0 THEN 0.00001 ELSE cte.RedThresholdValue END)*100 END) 
					WHEN cte.RedThresholdValue > cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) < cte.RedThresholdValue THEN 0 -- NOT RED
												ELSE (ISNULL(d.KPIValue, 0) - cte.RedThresholdValue)/(CASE WHEN cte.RedThresholdValue = 0 THEN 0.00001 ELSE cte.RedThresholdValue END)*100 END)
					END as PercentOverThresholdRed
			 , 
					CASE
						WHEN cte.RedThresholdValue > cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0)  >= cte.AmberThresholdValue AND ISNULL(d.KPIValue, 0) < cte.RedThresholdValue THEN (ISNULL(d.KPIValue, 0) - cte.AmberThresholdValue)/(CASE WHEN cte.AmberThresholdValue = 0 THEN 0.00001 ELSE cte.AmberThresholdValue END)*100 ELSE 0 END) 
						WHEN cte.RedThresholdValue < cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) <= cte.AmberThresholdValue AND ISNULL(d.KPIValue, 0) > cte.RedThresholdValue THEN (cte.AmberThresholdValue - ISNULL(d.KPIValue, 0))/(CASE WHEN cte.AmberThresholdValue = 0 THEN 0.00001 ELSE cte.AmberThresholdValue END)*100 ELSE 0 END) 
					END as PercentOverThresholdAmber
			 , 0 as PercentOverThresholdGreen	 
			 , mk.RedThresholdValue
			 , mk.AmberThresholdValue
			 , mk.GreenThresholdValue
			 , 
					case
						WHEN cte.RedThresholdValue < cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) > cte.RedThresholdValue THEN 0 -- NOT RED
												ELSE 1 END) 
						WHEN cte.RedThresholdValue > cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) < cte.RedThresholdValue THEN 0 -- NOT RED
												ELSE 1 END) 
					END as IsRed
			 , 
					CASE 
						WHEN cte.RedThresholdValue > cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) >= cte.AmberThresholdValue AND ISNULL(d.KPIValue, 0) < cte.RedThresholdValue THEN 1 ELSE 0 END) 
						WHEN cte.RedThresholdValue < cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) <= cte.AmberThresholdValue AND ISNULL(d.KPIValue, 0) > cte.RedThresholdValue THEN 1 ELSE 0 END) 
					END as IsAmber
			 , 
					CASE 
						WHEN cte.RedThresholdValue > cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) < cte.AmberThresholdValue THEN 1 ELSE 0 END) 
						WHEN cte.RedThresholdValue < cte.GreenThresholdValue THEN (CASE WHEN ISNULL(d.KPIValue, 0) > cte.AmberThresholdValue THEN 1 ELSE 0 END) 
					END as IsGreen
			 , rf.FrequencyName
			 , COALESCE(d.LastUpdatedDate, cte.KPILastUpdated)
			 , c.Category AS [RiskCategory]
			 , sc.SubCategory AS [RiskSubCategory]
			 , (SELECT MAX(LastUpdatedDate) FROM @KPIData) as MaxLastUpdatedDate
		FROM 
			[KPI].[MeasuredKPIs] mk
		INNER JOIN 
			[Core].[Roles] r ON r.RoleId = mk.OwnerRoleId
		LEFT JOIN 
			[KPI].[RefreshFrequency] rf ON mk.RefreshFrequencyId = rf.RefreshFrequencyId
		LEFT JOIN
			 @KPIData d ON d.KPIID = mk.KPIId
		LEFT JOIN 
			[KPI].[KPIRiskCategoryRelationship] krcr ON mk.KPIId = krcr.KPIID
		LEFT JOIN
			[KPI].[KPIGroupRelationship] kgr ON kgr.KPIId = mk.KPIId
		LEFT JOIN
			[KPI].[KPIGroups] kg ON kg.KPIGroupId = kgr.KPIGroupId
		LEFT JOIN [Risk].SubCategories sc 
			ON sc.SubCategoryId = krcr.RiskSubCategoryId
		LEFT JOIN [Risk].[Categories] c 
			ON c.CategoryId = sc.CategoryId
		LEFT JOIN CTE_LastUpdatedDate cte ON cte.KPIId = mk.KPIId
		WHERE mk.IsActive = 1

	RETURN
END


