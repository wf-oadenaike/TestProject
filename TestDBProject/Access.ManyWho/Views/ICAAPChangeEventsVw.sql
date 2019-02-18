CREATE VIEW [Access.ManyWho].[ICAAPChangeEventsVw]
	AS 
SELECT
	  ice.ICAAPChangeEventId
    , ice.ICAAPChangeId
    , ice.ICAAPChangeEventTypeId
	, ice.RecordedByPersonId
    , ice.EventDetails
    , ice.EventDate
    , ice.EventTrueFalse
	, ice.DocumentationFolderLink
	, ice.JoinGUID
	, ice.ICAAPChangeEventCreationDatetime
	, ice.ICAAPChangeEventLastModifiedDatetime
  FROM [Investment].[ICAAPChangeEvents] ice
