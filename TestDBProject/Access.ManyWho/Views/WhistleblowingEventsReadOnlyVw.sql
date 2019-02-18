
CREATE VIEW [Access.ManyWho].[WhistleblowingEventsReadOnlyVw]
	AS
	SELECT   wbe.WhistleblowingEventId
           , wbe.WhistleblowingId
           , wbe.WhistleblowingEventTypeId
		   , wbet.WhistleblowingEventType
	       , wbe.RecordedByPersonId
		   , rp.PersonsName as RecordedBy
           , wbe.EventDetails
           , wbe.EventDate
	       , wbe.DocumentationFolderLink
	       , wbe.JoinGUID	
	       , wbe.WhistleblowingEventCreationDate
	       , wbe.WhistleblowingEventLastModifiedDate
	FROM [Organisation].[WhistleblowingEvents] wbe
	INNER JOIN [Organisation].[WhistleblowingEventTypes] wbet
	   ON wbe.WhistleblowingEventTypeId = wbet.WhistleblowingEventTypeId
	LEFT OUTER JOIN Core.Persons rp
	   ON (wbe.RecordedByPersonId = rp.PersonId)
		;
