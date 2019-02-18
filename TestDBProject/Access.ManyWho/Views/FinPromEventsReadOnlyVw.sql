CREATE VIEW [Access.ManyWho].[FinPromEventsReadOnlyVw]
	AS SELECT FinPromEventId
		, FinPromRegisterId
		, FinPromEventType
		, EventPersonId
		, p.PersonsName
		, EventRoleId
		, EventTrueFalse
		, EventComments
		, EventDate
		, WorkflowVersionGUID
		, JoinGUID
		, FinPromEventCreationDate
		, FinPromEventLastModifiedDate
	 FROM [Investment].[FinPromEvents] fpe
			left join core.persons p
				on fpe.EventPersonId = p.PersonId

	 ;
