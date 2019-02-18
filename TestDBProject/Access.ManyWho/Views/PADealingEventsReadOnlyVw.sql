
CREATE VIEW [Access.ManyWho].[PADealingEventsReadOnlyVw]
	AS SELECT pre.PADealingEventId
		, pre.PADealingRegisterId
		, pre.PADealingEventTypeId
		, pdet.PADealingEventType
		, pre.SubmittedByPersonId
		, sp.PersonsName as PersonsName
		, pre.EventTrueFalse
		, pre.EventDetails
		, pre.EventDate
		, pre.DocumentationFolderLink
		, pre.JoinGUID
		, pre.JiraIssueKey
		, pre.PADealingEventCreationDatetime
		, pre.PADealingEventLastModifiedDatetime
	 FROM [Compliance].[PADealingEvents] pre
		INNER JOIN Core.Persons sp
			ON pre.SubmittedByPersonId = sp.PersonId
		INNER JOIN [Compliance].[PADealingEventTypes] pdet
			ON pre.PADealingEventTypeId = pdet.PADealingEventTypeId
	 ;

