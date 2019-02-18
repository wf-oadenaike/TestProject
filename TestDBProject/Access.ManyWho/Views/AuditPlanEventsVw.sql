
CREATE VIEW [Access.ManyWho].[AuditPlanEventsVw]
	AS SELECT AuditPlanEventId
		, AuditPlanRegisterId
		, AuditPlanEventType
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
		, AuditPlanEventCreationDate
		, AuditPlanEventLastModifiedDate
	 FROM [Internal.Audit].[AuditPlanEvents] pre
		INNER JOIN Core.Persons ep
			ON pre.EventPersonId = ep.PersonId
		INNER JOIN Core.Roles er
			ON pre.EventRoleId = er.RoleId
	 ;
