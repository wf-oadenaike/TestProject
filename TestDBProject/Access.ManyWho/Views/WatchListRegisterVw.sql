


CREATE VIEW [Access.ManyWho].[WatchListRegisterVw] AS
SELECT CWLR.[WatchListRegisterId]
      ,CWLR.[Description]
	  ,CWLR.[Identifier]
	  ,CWIT.[IdentifierName] as 'IdentifierTypeName'
	  ,CWLR.[IdentifierTypeId]
	  ,CWL.WatchlistCode as 'WatchlistCode'
      ,CWLR.[WatchlistId]
	  ,FS.FlowStatusName as 'Status'
      ,CWLR.[StatusId]
	  ,WRT.[ReasonName]
	  ,CWLR.[ReasonTypeId]
	  ,p1.PersonsName as 'SubmittedBy'
      ,CWLR.[SubmittedByPersonId]
	  ,p2.PersonsName as 'ReviewedBy'
      ,CWLR.[ReviewedByPersonId]
      ,CWLR.[AnticipatedRemovalDate]
      ,CWLR.[DateSubmitted]
      ,CWLR.[JIRAIssueKey]
	  ,CWLR.[BoxLink]
      ,CWLR.[JoinGUID]
	  ,CWLR.[CADIS_SYSTEM_INSERTED]
	  ,CWLR.[CADIS_SYSTEM_UPDATED]
	  ,CWLR.[CADIS_SYSTEM_CHANGEDBY]

FROM [dbo].[Compliance_WatchListRegister] CWLR

	LEFT OUTER JOIN [Core].[Persons] P1
	ON CWLR.[SubmittedByPersonId] = p1.PersonId

	LEFT OUTER JOIN [Core].[Persons] P2
	ON CWLR.[ReviewedByPersonId] = p2.PersonId

	LEFT OUTER JOIN [Core].[FlowStatus] FS
	ON CWLR.[StatusId] = FS.FlowStatusId

	LEFT OUTER JOIN [dbo].[Compliance_WatchLists] CWL
	ON CWLR.[WatchlistId] = CWL.WatchlistId

	LEFT OUTER JOIN [dbo].[Compliance_WatchlistIdentifierType] CWIT
    ON CWLR.[IdentifierTypeId] = CWIT.[IdentifierTypeId]

	LEFT OUTER JOIN [dbo].[Compliance_WatchlistReasonType] WRT
	ON CWLR.[ReasonTypeId] = WRT.[ReasonTypeId]


