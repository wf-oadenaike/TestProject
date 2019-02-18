
CREATE VIEW [Access.ManyWho].[KPIRiskSubCategoriesVw]
	AS 
SELECT
        kpi.KPIID
	  , kpi.KPIName
      , kpi.KPINameAlias as KPIDescription
	  , kpi.RedThresholdValue
	  , kpi.AmberThresholdValue
	  , kpi.GreenThresholdValue
	  , kpi.TargetValue
	  , rf.FrequencyName
	  , sc.SubCategoryId AS SubCategoryId
	  , sc.SubCategory AS RiskSubCategory
	  , sc.CategoryId AS RiskCategoryId
	  , c.Category AS RiskCategory
	  , pa.PersonId AS RiskOwnerId
	  , pa.PersonsName AS RiskOwner
	  , sc.RiskAppetite AS RiskAppetite
  FROM [Risk].[SubCategories] sc
  INNER JOIN [Risk].[Categories] c
    ON sc.CategoryId = c.CategoryId
  INNER JOIN [Risk].[SubCategoryRoleOwners] cro 
	ON cro.SubCategoryId = sc.SubCategoryId
  INNER JOIN [Access.ManyWho].PersonsActiveVw  pa 
	ON pa.AssignedRoleId = cro.RoleId
  INNER JOIN [KPI].[KPIRiskCategoryRelationship] rcr
	ON rcr.RiskSubCategoryId = sc.SubCategoryId
  INNER JOIN [KPI].[MeasuredKPIs] kpi
	ON rcr.KPIId = kpi.KPIId
  INNER JOIN [KPI].[RefreshFrequency] rf 
	ON kpi.RefreshFrequencyId = rf.RefreshFrequencyId


