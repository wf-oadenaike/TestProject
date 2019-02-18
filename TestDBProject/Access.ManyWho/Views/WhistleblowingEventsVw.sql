
CREATE VIEW [Access.ManyWho].[WhistleblowingEventsVw]
	AS
	SELECT   wbe.WhistleblowingEventId
           , wbe.WhistleblowingId
           , wbe.WhistleblowingEventTypeId
	       , wbe.RecordedByPersonId
           , wbe.EventDetails
           , wbe.EventDate
	       , wbe.DocumentationFolderLink
	       , wbe.JoinGUID	
	       , wbe.WhistleblowingEventCreationDate
	       , wbe.WhistleblowingEventLastModifiedDate
	FROM [Organisation].[WhistleblowingEvents] wbe
		;
