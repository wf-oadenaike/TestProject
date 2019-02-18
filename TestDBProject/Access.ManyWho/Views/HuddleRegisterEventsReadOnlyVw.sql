

CREATE VIEW [Access.ManyWho].[HuddleRegisterEventsReadOnlyVw]
	AS 
SELECT
	H.EventId,
	H.HuddleEventId,
	H.EventTypeId,
	HRE.EventTypeName as EventType,
	H.SubmittedByPersonId,
	CP1.PersonsName as SubmittedByName,
	H.EventDate,
	H.EventDetails,
	H.JiraIssueKey,
	H.JoinGUID
FROM [Organisation].[HuddleRegisterEvents]  H

Left JOIN [Core].[Persons] CP1 
ON H.SubmittedByPersonId = CP1.PersonId

Left JOIN [Organisation].[HuddleRegisterEventTypes] HRE 
ON H.EventTypeId = HRE.EventTypeId


