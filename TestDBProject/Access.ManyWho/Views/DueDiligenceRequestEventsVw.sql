

CREATE VIEW [Access.ManyWho].[DueDiligenceRequestEventsVw] AS
SELECT DDRE.[RequestEventID]
      ,DDRE.[ClientRequestID]
	  ,DDCR.ClientName as 'ClientName'
	  ,DDCR.ClientCompanyName as 'ClientCompanyName'
      ,DDRE.[EventType]
      ,DDRE.[ReviewerID]
	  ,p1.[PersonsName] as 'Reviewer'
      ,DDRE.[SubmittedByPersonID]
	  ,p2.[PersonsName] as 'Submittedby'
      ,DDRE.[EventDetails]
      ,DDRE.[EventDate]
      ,DDRE.[EventTrueFalse]
      ,DDRE.[EventStatus]
      ,DDRE.[JiraIssueKey]
      ,DDRE.[JoinGUID]
      ,DDRE.[CADIS_SYSTEM_INSERTED]
      ,DDRE.[CADIS_SYSTEM_UPDATED]
      ,DDRE.[CADIS_SYSTEM_CHANGEDBY]
FROM [Sales].[DueDiligenceRequestEvents] DDRE
    INNER JOIN [Core].[Persons] p1
        ON DDRE.ReviewerID = p1.PersonId
    LEFT OUTER JOIN [Core].[Persons] p2
        ON DDRE.SubmittedByPersonID = p2.PersonId
    LEFT OUTER JOIN [Sales].[DueDiligenceClientRequest] DDCR
        ON DDRE.[ClientRequestID] = DDCR.[ClientRequestID]



