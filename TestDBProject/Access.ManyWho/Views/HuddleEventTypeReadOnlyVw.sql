
create view [Access.ManyWho].[HuddleEventTypeReadOnlyVw]
as

-- DSB DAP-1238

select
het.EventTypeId
,het.[EventTypeName] 
,het.[EventTypeCode] 
,het.[EventTypeOwnerId]
,p.PersonsName as EventTypeOwnerName
,het.[CADIS_SYSTEM_INSERTED] 
,het.[CADIS_SYSTEM_UPDATED] 
,het.[CADIS_SYSTEM_CHANGEDBY] 

from [Organisation].[HuddleEventType] het
left join  Core.Persons p
on het.[EventTypeOwnerId] = p.PersonId
