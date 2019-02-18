


CREATE VIEW [Access.ManyWho].[WatchListEventsVw] AS
SELECT CWLE.[WatchlistEventId]
	  ,CWLE.[WatchlistRegisterId]
      ,CWLE.[EventTypeid]
	  ,WET.[WatchListEventType] as EventType
      ,CWLE.[EventDetails]
	  ,p1.PersonsName as 'SubmittedBy'
      ,CWLE.[SubmittedByPersonId]
      ,CWLE.[EventDate]
      ,CWLE.[EventTrueFalse]
      ,CWLE.[JIRAIssueKey]
      ,CWLE.[JoinGUID]
	  ,CWLE.[CADIS_SYSTEM_INSERTED]
	  ,CWLE.[CADIS_SYSTEM_UPDATED]
	  ,CWLE.[CADIS_SYSTEM_CHANGEDBY]

FROM [dbo].[Compliance_WatchListEvents] CWLE

	LEFT OUTER JOIN [Core].[Persons] P1
	ON CWLE.[SubmittedByPersonId] = p1.PersonId

	LEFT OUTER JOIN [dbo].[Compliance_WatchListEventTypes] WET
	ON CWLE.[EventTypeId] = WET.[WatchListEventTypeId]





