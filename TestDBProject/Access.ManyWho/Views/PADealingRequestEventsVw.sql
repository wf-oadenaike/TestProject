
CREATE VIEW [Access.ManyWho].[PADealingRequestEventsVw]
	AS SELECT PADealingRequestEventId
		, PADealingRequestRegisterId
		, PADealingRequestEventType
		, EventPersonId
		, ep.EmployeeBK as SalesforceUserId
		, ep.PersonsName as PersonsName
		, EventRoleId
		, er.RoleName as RoleName
		, EventTrueFalse
		, EventDetails
		, EventDate
		, DocumentationFolderLink
		, WorkflowVersionGUID
		, JoinGUID
		, PADealingRequestEventCreationDate
		, PADealingRequestEventLastModifiedDate
	 FROM [Compliance].[PADealingRequestEvents] pre
		INNER JOIN Core.Persons ep
			ON pre.EventPersonId = ep.PersonId
		INNER JOIN Core.Roles er
			ON pre.EventRoleId = er.RoleId
	 ;
