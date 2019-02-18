
CREATE VIEW [Access.ManyWho].[FinanceRequestEventsVw]
	AS
	SELECT   fre.FinanceRequestEventId
	       , fre.FinanceRequestId
	       , fre.FinanceRequestEventType
	       , fre.RecordedByPersonId
	       , fre.EventDetails
	       , fre.EventDate
	       , fre.EventTrueFalse
	       , fre.DocumentationFolderLink
	       , fre.JoinGUID
	       , fre.FinanceRequestEventCreationDatetime
	       , fre.FinanceRequestEventLastModifiedDatetime
	FROM [Organisation].[FinanceRequestEvents] fre
		;
