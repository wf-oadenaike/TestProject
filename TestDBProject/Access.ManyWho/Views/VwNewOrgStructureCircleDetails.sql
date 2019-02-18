


Create View [Access.ManyWho].[VwNewOrgStructureCircleDetails]
As
SELECT ci.[CircleId]
      ,ci.[Name] as CircleName
      ,ci.[ParentCircleId]
	  ,ci.Purpose
	  ,ca.Description as Accountability
  FROM [dbo].[NewOrgStructureCircles] ci
  left outer join [dbo].[NewOrgStructureCircleAccountabilities] ca on ci.CircleId = ca.CircleId

