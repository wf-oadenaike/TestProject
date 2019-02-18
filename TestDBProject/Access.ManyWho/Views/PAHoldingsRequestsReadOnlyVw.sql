CREATE VIEW [Access.ManyWho].[PAHoldingsRequestsReadOnlyVw]
AS

SELECT hr.[PAHoldingsRequestId]
      ,hr.[RequestDetails]
      ,op.personsname as 'OwnerName'
      ,rp.personsname as 'ReviewerName'
      ,hr.[Status]
      ,hr.[BoxFolderId]
      ,hr.[JIRAIssueKey]
      ,hr.[Active]
      ,hr.[DocumentationFolderLink]
      ,hr.[JoinGUID]
      ,hr.[PAHoldingsRequestCreationDatetime]
      ,hr.[PAHoldingsRequestLastModifiedDatetime]
      ,hr.[CADIS_SYSTEM_INSERTED]
      ,hr.[CADIS_SYSTEM_UPDATED]
      ,hr.[CADIS_SYSTEM_CHANGEDBY]
      ,hr.[CADIS_SYSTEM_PRIORITY]
      ,hr.[CADIS_SYSTEM_TIMESTAMP]
      ,hr.[CADIS_SYSTEM_LASTMODIFIED]

FROM [Compliance].[PAHoldingsRequests] hr
		join [Core].[Persons] op
			on hr.OwnerId = op.PersonId
		left outer join [Core].[Persons] rp
			on hr.ReviewerId = rp.PersonId
