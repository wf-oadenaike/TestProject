
CREATE VIEW [Reporting].[KPIFactAllVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Reporting].[KPIFactAllVw]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- OLU: Added FundShortName
--
-- 
-------------------------------------------------------------------------------------- 


WITH CTE_Date AS (
	SELECT 
		[KPIId], [MeasureDateId], MAX([LastUpdatedDatetime]) AS [LastUpdatedDatetime]
	FROM
		[Fact].[KPIFact]
	GROUP BY
		[KPIId], [MeasureDateId]
)
SELECT [KPIFactId]
      ,kf.[MeasureDateId]
	  ,C.CalendarDate AS KPIDate
      ,kf.[KPIId]
      ,[MeasureValue]
      ,kf.[LastUpdatedDatetime]
      ,ss.SourceSystemName
      ,[KPIName]
      ,[KPINameAlias]
      ,[KPIDescription]
      ,[KPIBK]
      ,[GreenThresholdValue]
      ,[AmberThresholdValue]
      ,[RedThresholdValue]
      ,[TargetValue]
      ,[Operator]
      ,[IsPercentage]
      ,[IsActive]
      ,[RefreshFrequencyId]
      ,[AggrFunction]
      ,[RoleName] AS [OwnerRole]
	  ,[Category] AS RiskCategory
	  ,[SubCategory] AS RiskSubCategory
	  ,[KPIGroupName]
	  ,mk.fund_short_name
  FROM [Fact].[KPIFact] kf
  INNER JOIN
	CTE_Date cte ON kf.KPIId = cte.KpiId AND kf.MeasureDateId = cte.MeasureDateId AND cte.LastUpdatedDatetime = kf.LastUpdatedDatetime
  INNER JOIN
	[Core].[Calendar] c ON c.CalendarId = kf.MeasureDateId
	INNER JOIN
	[KPI].[MeasuredKPIs] mk ON mk.KPIId = kf.KPIId
	INNER JOIN
	[Core].[Roles] r ON r.RoleId = mk.OwnerRoleId
	INNER JOIN
	[Audit].[SourceSystems] ss ON ss.SourceSystemId = kf.SourceSystemId
	LEFT JOIN
	[KPI].[KPIRiskCategoryRelationship] krcr ON krcr.KPIID = kf.KPIId
	LEFT JOIN
	[Risk].[SubCategories] sc ON sc.SubCategoryId = krcr.RiskSubCategoryId
	LEFT JOIN
	[Risk].[Categories] cat ON cat.CategoryId = sc.CategoryId
	LEFT JOIN
	[KPI].[KPIGroupRelationship] kgr ON kgr.KPIId = mk.KPIId
	LEFT JOIN
	[KPI].[KPIGroups] kg ON kg.KPIGroupId = kgr.KPIGroupId

