CREATE VIEW [Access.ManyWho].[RegulatoryInteractionEventsReadOnlyVw]
	AS 
SELECT
	   rie.RegulatoryInteractionEventId
     , rie.RegulatoryInteractionId
     , rie.RegulatoryInteractionEventTypeId
	 , riet.RegulatoryInteractionEventType
	 , rie.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
	 , rie.AssignedToPersonId
	 , ap.PersonsName as AssignedTo
     , rie.EventDetails
     , rie.EventDate
     , rie.EventTrueFalse
	 , rie.JiraTaskKey
     , rie.DocumentationFolderLink
     , rie.JoinGUID
     , rie.RegulatoryInteractionEventCreationDatetime
     , rie.RegulatoryInteractionEventLastModifiedDatetime
  FROM [Compliance].[RegulatoryInteractionEvents] rie
  INNER JOIN [Compliance].[RegulatoryInteractionEventTypes] riet
  ON rie.RegulatoryInteractionEventTypeId = riet.RegulatoryInteractionEventTypeId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON rie.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Core].[Persons] ap
  ON rie.AssignedToPersonId = Ap.PersonId
  ;
