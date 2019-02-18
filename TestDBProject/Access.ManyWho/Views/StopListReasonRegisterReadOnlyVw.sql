

CREATE VIEW [Access.ManyWho].[StopListReasonRegisterReadOnlyVw]
AS
SELECT        
	slrr.StopListReasonId, 
	slrr.StopListId,
	slr.StoppedCompanyName, 
	slrt.ReasonName, 
	sls.StopListStatusName, 
	slrr.ReasonTypeId, 
	slrr.StopListStatusId, 
	p1.PersonsName As ReasonOwner, 
	p2.PersonsName As Requester, 
	p3.PersonsName As Reviewer, 
	slrr.InteractionId, 
	slrr.ComplianceJiraIssueKey, 
	slrr.JIRAIssueKey, 
	slrr.StoppedDate, 
	slrr.AnticipatedCleanseDate, 
	slrr.AdvisedDate, 
	slrr.CleansedDate, 
	slrr.JoinGUID, 
	slrr.CADIS_SYSTEM_INSERTED, 
	slrr.CADIS_SYSTEM_UPDATED, 
	slrr.CADIS_SYSTEM_CHANGEDBY
FROM
	Compliance.StopListReasonRegister slrr
			
LEFT OUTER JOIN Compliance.StopListReasonType slrt ON slrr.ReasonTypeId = slrt.ReasonTypeId 
LEFT OUTER JOIN Compliance.StopListStatuses sls ON slrr.StopListStatusId = sls.StopListStatusId 
LEFT OUTER JOIN [Core].[Persons] p1 ON slrr.ReasonOwnerId = p1.PersonId 
LEFT OUTER JOIN [Core].[Persons] p2 ON slrr.RequesterPersonId = p2.PersonId  
LEFT OUTER JOIN [Core].[Persons] p3 ON slrr.ReviewerPersonId = p3.PersonId 
LEFT OUTER JOIN [Compliance].[StopListRegister] slr ON slrr.StopListId = slr.StopListId



