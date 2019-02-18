
CREATE VIEW [Access.ManyWho].[FinanceRequestEventsReadOnlyVw]
	AS
	SELECT   fre.FinanceRequestEventId
	       , fre.FinanceRequestId
	       , fre.FinanceRequestEventType
	       , fre.RecordedByPersonId
		   , rp.PersonsName as RecordedBy
	       , fre.EventDetails
	       , fre.EventDate
	       , fre.EventTrueFalse
	       , fre.DocumentationFolderLink
	       , fre.JoinGUID
	       , fre.FinanceRequestEventCreationDatetime
	       , fre.FinanceRequestEventLastModifiedDatetime
	FROM [Organisation].[FinanceRequestEvents] fre
	LEFT OUTER JOIN [Core].[Persons] rp
	ON fre.RecordedByPersonId = rp.PersonId	
		;
