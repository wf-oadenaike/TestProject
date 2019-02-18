CREATE VIEW [Access.ManyWho].[ShareClassWaiverEventsReadOnlyVw]
	AS 
SELECT
	   sce.ShareClassWaiverEventId
     , sce.ShareClassWaiverId
     , sce.ShareClassWaiverEventTypeId
	 , scet.ShareClassWaiverEventType
	 , sce.SubmittedByPersonId
	 , sp.PersonsName as SubmittedBy
     , sce.EventDetails
     , sce.EventDate
     , sce.EventTrueFalse
     , sce.DocumentationFolderLink
     , sce.JoinGUID
     , sce.ShareClassWaiverEventCreationDatetime
     , sce.ShareClassWaiverEventLastModifiedDatetime
  FROM [Investment].[ShareClassWaiverEvents] sce
  INNER JOIN [Investment].[ShareClassWaiverEventTypes] scet
  ON sce.ShareClassWaiverEventTypeId = scet.ShareClassWaiverEventTypeId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON sce.SubmittedByPersonId = sp.PersonId

  ;
