

CREATE VIEW [Access.ManyWho].[CriticalUserDefinedToolsEventsReadOnlyVw]
	AS 
SELECT
	EventId,
	ToolId,
	EventDetails,
	SubmittedByPersonId,
	cp.PersonsName as SubmittedByPersonName,
	EventDate,
	EventType,
	JoinGUID
  FROM [Organisation].[CriticalUserDefinedToolsEvents] cude
  INNER JOIN [Core].[Persons] cp
  ON cude.SubmittedByPersonId = cp.PersonId


