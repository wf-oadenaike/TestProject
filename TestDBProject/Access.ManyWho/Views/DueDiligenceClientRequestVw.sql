
CREATE VIEW [Access.ManyWho].[DueDiligenceClientRequestVw] AS
SELECT [ClientRequestID]
      ,[RequestTypeID]
	  ,DDRT.ClientRequestType as 'RequestType'
	  ,[ClientName]
      ,[ClientCompanyName]
      ,[RelationshipManagerID]
	  ,p1.PersonsName as 'RelationshipManager'
      ,[ReviewerID]
	  ,p2.PersonsName as 'Reviewer'
      ,[ClientAssessmentID]
      ,[JiraEpicKey]
      ,[Status]
	  ,[CEOSignOffRequired]
	  ,[DueDateOverride]
	  ,[DueDate]
	  ,[SlackChannelName]
	  ,[CoachingRequired]
	  ,[DocumentsRequired]
      ,[JoinGUID]
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
FROM [Sales].[DueDiligenceClientRequest] DDCR
    INNER JOIN [Core].[Persons] p1
        ON DDCR.[RelationshipManagerID] = p1.PersonId
    LEFT OUTER JOIN [Core].[Persons] p2
        ON DDCR.[ReviewerID] = p2.PersonId
	INNER JOIN [Sales].[DueDiligenceRequestType] DDRT
		ON DDCR.[RequestTypeID] = DDRT.TypeID




