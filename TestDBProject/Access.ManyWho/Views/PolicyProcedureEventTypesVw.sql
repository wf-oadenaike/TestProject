CREATE VIEW [Access.ManyWho].[PolicyProcedureEventTypesVw]
	AS 
	SELECT PolicyThemeEventTypeId AS PolicyProcedureEventTypeId, PolicyThemeEventTypeBK AS PolicyProcedureEventTypeBK
			, PolicyThemeEventDescription AS PolicyProcedureEventDescription
	FROM [Organisation].[PolicyThemeEventTypes]
	;
