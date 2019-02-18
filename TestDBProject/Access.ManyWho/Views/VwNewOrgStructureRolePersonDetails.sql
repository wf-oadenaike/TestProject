Create View [Access.ManyWho].[VwNewOrgStructureRolePersonDetails]
As
SELECT ro.RoleId
      ,ro.Name as RoleName
      ,ro.Purpose
	  ,ro.CircleId
	  ,ci.Name as CircleName
	  ,ro.CoreRoleFlag
	  ,ro.FocusArea
	  ,case when (select count(*) from dbo.NewOrgStructurePersonRoles pr where pr.RoleId = ro.RoleId) = 0 then 'unfilled' else 'filled' end as RoleStatus
	  ,pav.PersonId
	  ,pav.PersonsName
  FROM [dbo].[NewOrgStructureRoles] ro
  join [dbo].[NewOrgStructureCircles] ci on ci.CircleId = ro.CircleId
  left outer join [dbo].[NewOrgStructurePersonRoles] pr on pr.RoleId = ro.RoleId
  join [Access.ManyWho].[PersonsActiveVw] pav on pav.PersonId = pr.PersonId
  where ro.IsActive = 1 

Union 

SELECT ro.RoleId
      ,ro.Name as RoleName
      ,ro.Purpose
	  ,ci.CircleId
	  ,ci.Name as CircleName
	  ,ro.CoreRoleFlag
	  ,ro.FocusArea
	  ,case when ci.CircleLead is null then 'unfilled' else 'filled' end as RoleStatus
	  ,pav.PersonId
	  ,pav.PersonsName
FROM [dbo].[NewOrgStructureCircles] ci
join [dbo].[NewOrgStructureRoles] ro on ro.RoleId = 1
left outer join [Access.ManyWho].[PersonsActiveVw] pav on pav.PersonId = ci.CircleLead
where ci.HasCircleLead = 1

Union

SELECT ro.RoleId
      ,ro.Name as RoleName
      ,ro.Purpose
	  ,ci.CircleId
	  ,ci.Name as CircleName
	  ,ro.CoreRoleFlag
	  ,ro.FocusArea
	  ,case when ci.Facilitator is null then 'unfilled' else 'filled' end as RoleStatus
	  ,pav.PersonId
	  ,pav.PersonsName
FROM [dbo].[NewOrgStructureCircles] ci
join [dbo].[NewOrgStructureRoles] ro on ro.RoleId = 2
left outer join [Access.ManyWho].[PersonsActiveVw] pav on pav.PersonId = ci.Facilitator
where ci.HasFacilitator = 1

