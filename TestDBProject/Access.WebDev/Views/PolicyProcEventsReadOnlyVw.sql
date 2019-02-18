
CREATE VIEW [Access.WebDev].[PolicyProcEventsReadOnlyVw]
	AS 
	SELECT ev.EventId
	  , ev.PolicyId
	  , ev.ProcDocumentId
	  , ev.EventTypeId
	  , evt.EventType
	  , ev.SubmittedByPersonId
	  , sp.PersonsName as SubmittedBy
	  , ev.EventDetails
	  , ev.EventDate
	  , ev.EventStatus
	  , ev.EventTrueFalse
	  , ev.JiraTaskKey
	  , ev.IsLegalStatusChange
	  , ev.IsRebrand
	  , ev.IsContentChange
	  , ev.DocumentationFolderLink
	  , ev.JoinGUID
	  , ev.EventCreationDatetime
	  , ev.EventLastModifiedDatetime
	FROM [PolicyProc].[Events] ev
	INNER JOIN [PolicyProc].[EventTypes] evt
	ON ev.EventTypeId = evt.EventTypeId
	INNER JOIN [Core].[Persons] sp
	ON ev.SubmittedByPersonId = sp.PersonId
	;
