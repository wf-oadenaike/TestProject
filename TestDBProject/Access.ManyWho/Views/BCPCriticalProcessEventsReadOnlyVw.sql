CREATE VIEW [Access.ManyWho].[BCPCriticalProcessEventsReadOnlyVw]
	AS 
SELECT	
	  cpe.BCPCriticalProcessEventId
    , cpe.BCPCriticalProcessId
	, cpe.RecordedByPersonId
	, rp.PersonsName as RecordedBy	
    , cpe.EventDetails
	, cpe.EventType
    , cpe.EventDate
	, cpe.Status
    , cpe.TechnologyDetails
	, cpe.ProcessPersonId
	, pp.PersonsName as ProcessPerson
	, cpe.Supplier
    , cpe.DocumentationFolderLink
    , cpe.JoinGUID
    , cpe.BCPCriticalProcessEventCreationDate
    , cpe.BCPCriticalProcessEventLastModifiedDatetime
  FROM [BAU].[BCPCriticalProcessEvents] cpe
  INNER JOIN [Core].[Persons] rp
  ON cpe.RecordedByPersonId = rp.PersonId
  LEFT OUTER JOIN [Core].[Persons] pp
  ON cpe.ProcessPersonId = pp.PersonId
  
  
  ;
