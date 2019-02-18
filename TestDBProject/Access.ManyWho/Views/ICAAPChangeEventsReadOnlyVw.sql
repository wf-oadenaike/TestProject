CREATE VIEW [Access.ManyWho].[ICAAPChangeEventsReadOnlyVw]
	AS 
SELECT
	  ice.ICAAPChangeEventId
    , ice.ICAAPChangeId
    , ice.ICAAPChangeEventTypeId
	, icet.ICAAPChangeEventType
	, ice.RecordedByPersonId
	, rp.PersonsName as RecordedBy
    , ice.EventDetails
    , ice.EventDate
    , ice.EventTrueFalse
	, ice.DocumentationFolderLink
	, ice.JoinGUID
	, ice.ICAAPChangeEventCreationDatetime
	, ice.ICAAPChangeEventLastModifiedDatetime
  FROM [Investment].[ICAAPChangeEvents] ice
  INNER JOIN [Investment].[ICAAPChangeEventTypes] icet
  ON ice.ICAAPChangeEventTypeId = icet.ICAAPChangeEventTypeId
  LEFT OUTER JOIN [Core].[Persons] rp
  ON ice.RecordedByPersonId = rp.PersonId;
