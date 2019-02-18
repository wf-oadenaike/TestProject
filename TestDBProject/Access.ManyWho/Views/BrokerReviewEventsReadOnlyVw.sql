CREATE VIEW [Access.ManyWho].[BrokerReviewEventsReadOnlyVw]
	AS 
SELECT
	   bre.BrokerReviewEventId
     , bre.BloombergId
	 , mb.BrokerName
     , bre.BrokerReviewEventTypeId
	 , bret.BrokerReviewEventType
	 , bre.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
     , bre.EventDetails
     , bre.EventDate
     , bre.EventTrueFalse
     , bre.DocumentationFolderLink
     , bre.JoinGUID
     , bre.BrokerReviewEventCreationDatetime
     , bre.BrokerReviewEventLastModifiedDatetime
  FROM [Organisation].[BrokerReviewEvents] bre
  INNER JOIN [Organisation].[BrokerReviewEventTypes] bret
  ON bre.BrokerReviewEventTypeId = bret.BrokerReviewEventTypeId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON bre.SubmittedByPersonId = sp.PersonId
  LEFT OUTER JOIN [Access.ManyWho].[MasterBrokersVw] mb
  ON bre.BloombergId = mb.BloombergId

  ;
