CREATE VIEW [Access.ManyWho].[BCPCriticalProcessEventsVw]
	AS 
SELECT
	  cpe.BCPCriticalProcessEventId
    , cpe.BCPCriticalProcessId
	, cpe.RecordedByPersonId
    , cpe.EventDetails
	, cpe.EventType
    , cpe.EventDate
	, cpe.Status
	, cpe.TechnologyDetails
	, cpe.ProcessPersonId
	, cpe.[Supplier]
    , cpe.DocumentationFolderLink
    , cpe.JoinGUID
    , cpe.BCPCriticalProcessEventCreationDate
    , cpe.BCPCriticalProcessEventLastModifiedDatetime
  FROM [BAU].[BCPCriticalProcessEvents] cpe
  ;
