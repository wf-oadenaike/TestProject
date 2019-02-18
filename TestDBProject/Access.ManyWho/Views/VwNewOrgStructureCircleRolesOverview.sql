Create View [Access.ManyWho].[VwNewOrgStructureCircleRolesOverview]
As
SELECT ci.[CircleId]
      ,ci.[Name] as CircleName
	  ,ci.[Label] as CircleLabel
      ,ci.[ParentCircleId]
	  ,cr.RoleId
	  ,cr.Name as RoleName
	  ,cr.CoreRoleFlag
	  ,case when (select count(*) from dbo.NewOrgStructurePersonRoles pr where pr.RoleId = cr.RoleId) = 0 then 'unfilled' else 'filled' end as RoleStatus
FROM [dbo].[NewOrgStructureCircles] ci
left outer join [dbo].[NewOrgStructureRoles] cr on cr.CircleId = ci.CircleId
where ci.IsActive = 1 and cr.IsActive = 1 

Union  


SELECT ci.[CircleId]
      ,ci.[Name] as CircleName
	  ,ci.[Label] as CircleLabel
      ,ci.[ParentCircleId]
	  ,cr.RoleId
	  ,cr.Name as RoleName
	  ,cr.CoreRoleFlag
	  ,case when ci.CircleLead is null then 'unfilled' else 'filled' end as RoleStatus
FROM [dbo].[NewOrgStructureCircles] ci
left outer join [dbo].[NewOrgStructureRoles] cr on cr.RoleId = 1
where ci.IsActive = 1 and cr.IsActive = 1 and ci.HasCircleLead = 1

Union

SELECT ci.[CircleId]
      ,ci.[Name] as CircleName
	  ,ci.[Label] as CircleLabel
      ,ci.[ParentCircleId]
	  ,cr.RoleId
	  ,cr.Name as RoleName
	  ,cr.CoreRoleFlag
	  ,case when ci.Facilitator is null then 'unfilled' else 'filled' end as RoleStatus
FROM [dbo].[NewOrgStructureCircles] ci
left outer join [dbo].[NewOrgStructureRoles] cr on cr.RoleId = 2
where ci.IsActive = 1 and cr.IsActive = 1 and ci.HasFacilitator = 1
