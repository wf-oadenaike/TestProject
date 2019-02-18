CREATE VIEW [Access.ManyWho].[PolicyProceduresEventsVw]
	AS 
	SELECT pte.PolicyThemeEventId AS PolicyProceduresEventId, pte.PolicyThemeRegisterId AS PolicyProcedureRegisterId
		, pte.PolicyThemeEventTypeId AS PolicyProcedureEventTypeId
		, ppet.PolicyThemeEventTypeBK AS PolicyProcedureEventTypeBK
		, pte.PersonId, p.EmployeeBK as SalesforceUserId
		, pte.RoleId, r.RoleName
		, pte.EventDetails, pte.EventDate, pte.EventTrueFalse
		, pte.DocumentationFolderLink, pte.JoinGUID
		, pte.PolicyThemeEventCreationDatetime AS PolicyProcedureEventCreationDate
		, pte.PolicyThemeEventLastModifiedDatetime AS PolicyProcedureEventLastModifiedDate
	FROM [Organisation].[PolicyThemeEvents] pte
		LEFT OUTER JOIN Core.Persons p
			ON pte.PersonId = p.PersonId
		LEFT OUTER JOIN Core.Roles r
			ON pte.RoleId = r.RoleId
		LEFT OUTER JOIN [Organisation].PolicyThemeEventTypes ppet
			ON pte.PolicyThemeEventTypeId = ppet.PolicyThemeEventTypeId
	;
