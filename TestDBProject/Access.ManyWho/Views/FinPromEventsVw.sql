
CREATE VIEW [Access.ManyWho].[FinPromEventsVw]
	AS SELECT FinPromEventId
		, FinPromRegisterId
		, FinPromEventType
		, EventPersonId
		, EventRoleId
		, EventTrueFalse
		, EventComments
		, EventDate
		, WorkflowVersionGUID
		, JoinGUID
		, FinPromEventCreationDate
		, FinPromEventLastModifiedDate
	 FROM [Investment].[FinPromEvents] fpe

	 ;
