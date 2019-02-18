CREATE VIEW [Access.ManyWho].[StopListEventsReadOnlyVw]
AS
SELECT        
	sle.StopListEventId, 
	sle.StopListReasonId, 
	sle.EventDetails,
	sle.EventDate, 
	slst.StopListStatusName,
	sle.SubmittedByPersonId,
	p1.PersonsName As SubmittedBy, 
	sle.JIRAIssueKey, 
	sle.JoinGUID, 
	sle.CADIS_SYSTEM_INSERTED, 
	sle.CADIS_SYSTEM_UPDATED, 
	sle.CADIS_SYSTEM_CHANGEDBY
FROM
	[Compliance].[StopListEvents]  sle
			
LEFT OUTER JOIN [Compliance].[StopListStatuses] slst ON sle.StopListStatusId = slst.StopListStatusId  
LEFT OUTER JOIN [Core].[Persons] p1 ON sle.SubmittedByPersonId = p1.PersonId 
