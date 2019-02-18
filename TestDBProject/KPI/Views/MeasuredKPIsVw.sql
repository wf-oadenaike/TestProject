
CREATE VIEW [KPI].[MeasuredKPIsVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [KPI].[MeasuredKPIsVw]
-- 
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- OLU: Added FundShortName
--
-- 
-------------------------------------------------------------------------------------- 

-- View logic goes here
 SELECT mk.KPIId 
		, mk.KPIName
		, mk.KPINameAlias
		, mk.KPIDescription
		, mk.fund_short_name
		, mk.KPIBK 
		, mk.GreenThresholdValue 
		, mk.AmberThresholdValue 
		, mk.RedThresholdValue 
		, mk.TargetValue 
		, mk.Operator
		, mk.IsPercentage 
		, mk.IsActive 
		, mk.RefreshFrequencyId
		, rf.FrequencyName
		, mk.AggrFunction
		, mk.OwnerRoleId
		, r.RoleName
	 FROM [KPI].[MeasuredKPIs] mk
		INNER JOIN Core.Roles r
			ON mk.OwnerRoleId = r.RoleId
		INNER JOIN KPI.RefreshFrequency rf
			ON mk.RefreshFrequencyId = rf.RefreshFrequencyId
	 ;

