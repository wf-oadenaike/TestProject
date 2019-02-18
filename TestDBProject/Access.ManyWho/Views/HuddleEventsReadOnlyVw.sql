






CREATE view [Access.ManyWho].[HuddleEventsReadOnlyVw]
as
-- DSB DAP-1238
-- JDT DAP-1402
-- RD  DAP-1483
select 
he.[EventId]
,he.[EventSummary] 
,he.[EventDate] 
,he.[DateIdentified]  
,he.[ReportedDate]
,he.EventName
,he.IsActive
,he.ActualEvent
,het.CategoryId
,rc.Category
,he.SubCategoryId
,het.SubCategory
,he.WorstCaseScenario
,he.PotentialLoss
,he.[JIRAKey] 
,he.[JoinGUID]
,he.[SlackChannel]
,he.[RecordedByPersonId]
,p1.PersonsName as RecordedBy
,he.[ReportedByPersonId]
,p2.PersonsName as ReportedBy
,he.EventOwnerPersonId
,p3.Personsname as EventOwner
,he.[CADIS_SYSTEM_INSERTED]
,he.[CADIS_SYSTEM_UPDATED] 
,he.[CADIS_SYSTEM_CHANGEDBY] 

from [Organisation].[HuddleEvents] he
left join Risk.SubCategories het
on he.SubCategoryId = het.SubCategoryId
left join  Core.Persons p1
on he.[RecordedByPersonId] = p1.PersonId
left join  Core.Persons p2
on he.[ReportedByPersonId] = p2.PersonId
left join  Core.Persons p3
on he.[EventOwnerPersonId] = p3.PersonId
left join [Risk].[Categories] rc
on het.CategoryId = rc.CategoryId








