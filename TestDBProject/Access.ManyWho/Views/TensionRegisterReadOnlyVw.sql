
CREATE VIEW  [Access.ManyWho].[TensionRegisterReadOnlyVw]

AS

-------------------------------------------------------------------------------------- 
-- Name: [Access.ManyWho].[TensionRegisterReadOnlyVw]
-------------------------------------------------------------------------------------- 
-- History:

-- WHO WHEN WHY
-- B.Katsadoros: 19/11/2018 JIRA: PRP-7220
-------------------------------------------------------------------------------------- 

SELECT
tr.[TensionId]
,tr.[TensionSummary]
,tr.[TensionDescription]
,tr.[TensionResolution]
,tr.[ResolutionDate]
,tr.[CircleId]
,sc.[Name] as CircleName
,tr.[RaisedByPersonId]
,p1.PersonsName as RaisedBy
,tr.[JIRAKey]
,tr.[JoinGUID]
,tr.[SlackChannel]
,tr.IsActive
,tr.[CADIS_SYSTEM_INSERTED]
,tr.[CADIS_SYSTEM_UPDATED] 
,tr.[CADIS_SYSTEM_CHANGEDBY] 

from [dbo].[TensionRegister] tr
left join  Core.Persons p1
on tr.[RaisedByPersonId] = p1.PersonId
left join [dbo].[NewOrgStructureCircles] sc
on tr.[CircleId] = sc.[CircleId]

