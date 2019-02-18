CREATE VIEW [Compliance].[ConflictsRegisterReadOnlyVw]
	AS
WITH ClientsCTE AS (
	SELECT
		ConflictId,
		stuff((
		  SELECT ',' + t.ClientName 
			  FROM     [Compliance].[ConflictsRegisterClients]  AS t 
			  WHERE  (t.ConflictId = crc.ConflictId)
					  ORDER BY t.CreationDate
			   for xml path('')
			   ),1,1,'') as Clients,
		stuff((
		  SELECT ',' + t.ClientSalesforceId
			  FROM     [Compliance].[ConflictsRegisterClients]  AS t 
			  WHERE  (t.ConflictId = crc.ConflictId)
					  ORDER BY t.CreationDate
			   for xml path('')
			   ),1,1,'') as ClientSalesforceIds
		from [Compliance].[ConflictsRegisterClients] crc
		group by ConflictId
),

Info_CTE AS (
	SELECT
		ConflictId,
		stuff((
		  SELECT ',' + CONVERT(VARCHAR(31),t.InteractionDate) + ' - ' + tt.UserInteractionType + ' - ' + t.InteractionMessage
			  FROM     [Compliance].[ConflictsRegisterUserInteractions]  AS t
			  INNER JOIN  [Compliance].[ConflictsRegisterUserInteractionTypes] tt ON tt.UserInteractionTypeId = t.UserInteractionTypeId
			  WHERE  (t.ConflictId = crui.ConflictId)
					  ORDER BY t.InteractionDate DESC
			   for xml path('')
			   ),1,1,'') as Messages
		from [Compliance].[ConflictsRegisterUserInteractions] crui
		group by ConflictId
)
SELECT crp.[ConflictId]
		,COALESCE(cri.ConflictIdentifierOverride, cri.ConflictIdentifier) AS [ConflictIdentifier]
		,(CASE WHEN closed.ActionDate IS NOT NULL THEN 0 ELSE 1 END) AS IsOpen
      ,[NotifyingPersonId]
	  , p1.PersonsName AS NotifyingPerson
      ,[ConflictEntryDate]
	  ,[RecognitionDate]
	  ,c_CTE.ClientSalesforceIds  AS [PotentialConflictClientSalesforceId]
      ,c_CTE.Clients AS [PotentialConflictClientSalesforceName]
      ,[PotentialConflictSummary]
      ,[PotentialConflictDetails]
	  ,i_CTE.[Messages] AS [ClientInformationRequestConversion]
	  ,SMNotification.ActionDate AS SeniorManagementNotificationDate
	  ,SMNotification.ActionComment AS SeniorManagementNotification
	  ,crm.MitigationDetails
	  ,crm2.MeetingDate
	  ,crm2.MeetingOutcome
	  ,nextReview.ActionDate AS NextReviewDate
	  ,nextReview.ActionComment AS NextReviewNote
	  ,cri.DocumentationFolderUrl
	  ,ClientNotification.ActionDate AS ClientNotificationDate
	  ,ClientNotification.ActionComment AS ClientNotificationDetails
	  ,closed.ActionDate AS ClosedOnDate
	  ,closed.ActionComment AS ClosingComment
	  ,crCat1.ConflictsRegisterCategory AS Category1
	  ,crCat2.ConflictsRegisterCategory AS Category2
      ,[WorkflowVersionGUID]
      ,[JoinGUID]
  FROM [Compliance].[ConflictsRegisterPotential] crp
  LEFT JOIN [Compliance].[ConflictsRegisterIdentification] cri ON crp.ConflictId = cri.ConflictId
  LEFT JOIN [Compliance].[ConflictsRegisterMitigation] crm ON crm.ConflictId = crp.ConflictId
  LEFT JOIN [Compliance].[ConflictsRegisterMeetings] crm2 ON crm2.ConflictId = crp.ConflictId
  LEFT JOIN [Compliance].[ConflictsRegisterActions] nextReview ON nextReview.ConflictId = crp.ConflictId AND nextReview.ActionTypeId = 1
  LEFT JOIN [Compliance].[ConflictsRegisterActions] closed ON closed.ConflictId = crp.ConflictId AND closed.ActionTypeId = 3
  LEFT JOIN [Compliance].[ConflictsRegisterActions] SMNotification ON SMNotification.ConflictId = crp.ConflictId AND SMNotification.ActionTypeId = 2
  LEFT JOIN [Compliance].[ConflictsRegisterActions] ClientNotification ON ClientNotification.ConflictId = crp.ConflictId AND ClientNotification.ActionTypeId = 4
  LEFT JOIN [Core].[Persons] p1 ON p1.personId = crp.NotifyingPersonId
  LEFT JOIN ClientsCTE c_CTE ON c_CTE.ConflictId = crp.ConflictId
  LEFT JOIN Info_CTE i_CTE ON i_CTE.ConflictId = crp.ConflictId
  LEFT JOIN [Compliance].[ConflictsRegisterCategories] crCat1 ON crCat1.ConflictsRegisterCategoryId = cri.ConflictsRegisterCategoryId1
  LEFT JOIN [Compliance].[ConflictsRegisterCategories] crCat2 ON crCat1.ConflictsRegisterCategoryId = cri.ConflictsRegisterCategoryId2
