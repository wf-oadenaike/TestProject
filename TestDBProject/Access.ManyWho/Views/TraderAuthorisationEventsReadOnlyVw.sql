CREATE VIEW [Access.ManyWho].[TraderAuthorisationEventsReadOnlyVw]
	AS 
SELECT
	   tae.TraderAuthorisationEventId
     , tae.TraderAuthorisationId
     , tae.EventType
	 , tae.RecordedByPersonId
	 , p.PersonsName as RecordedBy
     , tae.EventDetails
     , tae.EventDate
     , tae.EventTrueFalse
	 , tae.Status
	 , tae.JiraKey
     , tae.DocumentationFolderLink
     , tae.JoinGUID
     , tae.TraderAuthorisationEventCreationDatetime
     , tae.TraderAuthorisationEventLastModifiedDatetime
  FROM [Compliance].[TraderAuthorisationEvents] tae
  INNER JOIN [Core].[Persons] p
  ON tae.RecordedByPersonId = p.PersonId

  ;
