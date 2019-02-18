CREATE VIEW [Access.ManyWho].[ClientBillingEventsReadOnlyVw]
	AS 
SELECT
	   cbe.ClientBillingEventId
     , cbe.ClientBillingId
     , cbe.EventTypeId
	 , cbet.ClientBillingEventType
	 , cbe.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
     , cbe.EventDetails
     , cbe.EventDate
     , cbe.EventTrueFalse
     , cbe.DocumentationFolderLink
     , cbe.JoinGUID
     , cbe.ClientBillingEventCreationDate
     , cbe.ClientBillingEventLastModifiedDatetime
  FROM [Sales].[ClientBillingEvents] cbe
  INNER JOIN [Sales].[ClientBillingEventTypes] cbet
  ON cbe.EventTypeId = cbet.ClientBillingEventTypeId 
  INNER JOIN [Core].[Persons] sp
  ON cbe.SubmittedByPersonId = sp.PersonId

  ;
