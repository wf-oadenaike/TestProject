CREATE VIEW [Access.ManyWho].[PolicyThemeEventTypesVw]
	AS 
	SELECT PolicyThemeEventTypeId AS PolicyProcedureEventTypeId, PolicyThemeEventTypeBK AS PolicyProcedureEventTypeBK
			, PolicyThemeEventDescription AS PolicyProcedureEventDescription
	FROM [Organisation].[PolicyThemeEventTypes]
	;
