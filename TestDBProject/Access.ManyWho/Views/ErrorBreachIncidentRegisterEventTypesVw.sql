CREATE VIEW [Access.ManyWho].[ErrorBreachIncidentRegisterEventTypesVw]
	AS
	SELECT EBIEventTypeId, EBIEventTypeBK, EBIEventDescription
	FROM [Compliance].[ErrorBreachIncidentRegisterEventTypes];
