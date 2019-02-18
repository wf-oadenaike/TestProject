CREATE VIEW [Access.ManyWho].[NewProjectEventsReadOnlyVw]
	AS 
SELECT
	   npe.ProjectEventId
     , npe.ProjectId
     , npr.ProjectName
     , npe.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , npe.EventType
	 , npe.EventStatus
     , npe.EventDetails
     , npe.EventDate
     , npe.EventTrueFalse
     , npe.ItemNumber
     , npe.Cost
	 , npe.JiraIssueKey
     , npe.DocumentationFolderLink
     , npe.JoinGUID
     , npe.NewProjectEventCreationDatetime
     , npe.NewProjectEventLastModifiedDatetime
  FROM [Organisation].[NewProjectEvents] npe
  INNER JOIN [Organisation].[NewProjectsRegister] npr
  ON npe.ProjectId = npr.ProjectId
  INNER JOIN [Core].[Persons] sp
  ON npe.SubmittedByPersonId = sp.PersonId

  ;
