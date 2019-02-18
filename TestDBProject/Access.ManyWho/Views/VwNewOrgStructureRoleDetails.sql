Create View [Access.ManyWho].[VwNewOrgStructureRoleDetails]
As
SELECT ro.RoleId
      ,ro.Name as RoleName
      ,ro.Purpose
	  ,ro.CircleId
	  ,ci.Name as CircleName
	  ,ro.CoreRoleFlag
	  ,ro.FocusArea
	  ,ra.Description as Accountability
	  ,case when (select count(*) from dbo.NewOrgStructurePersonRoles pr where pr.RoleId = ro.RoleId) = 0 then 'unfilled' else 'filled' end as RoleStatus
FROM [dbo].[NewOrgStructureRoles] ro
left outer join [dbo].[NewOrgStructureRoleAccountabilities] ra on ro.RoleId = ra.RoleId
join [dbo].[NewOrgStructureCircles] ci on ci.CircleId = ro.CircleId
where ro.IsActive = 1 and ra.IsActive = 1

Union  

SELECT ro.RoleId
      ,ro.Name as RoleName
      ,ro.Purpose
	  ,ci.CircleId
	  ,ci.Name as CircleName
	  ,ro.CoreRoleFlag
	  ,ro.FocusArea
	  ,ra.Description as Accountability
	  ,case when ci.CircleLead is null then 'unfilled' else 'filled' end as RoleStatus
FROM [dbo].[NewOrgStructureCircles] ci
join [dbo].[NewOrgStructureRoles] ro on ro.RoleId = 1
join [dbo].[NewOrgStructureRoleAccountabilities] ra on ro.RoleId = ra.RoleId
where ro.IsActive = 1 and ra.IsActive = 1 and ci.HasCircleLead = 1

Union 

SELECT ro.RoleId
      ,ro.Name as RoleName
      ,ro.Purpose
	  ,ci.CircleId
	  ,ci.Name as CircleName
	  ,ro.CoreRoleFlag
	  ,ro.FocusArea
	  ,ra.Description as Accountability
	  ,case when ci.Facilitator is null then 'unfilled' else 'filled' end as RoleStatus
FROM [dbo].[NewOrgStructureCircles] ci
join [dbo].[NewOrgStructureRoles] ro on ro.RoleId = 2
join [dbo].[NewOrgStructureRoleAccountabilities] ra on ro.RoleId = ra.RoleId
where ro.IsActive = 1 and ra.IsActive = 1 and ci.HasFacilitator = 1
