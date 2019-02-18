CREATE VIEW [Access.ManyWho].[AuditEventTypesVw]
	AS
	SELECT AuditEventTypeId, AuditEventTypeBK, AuditEventDescription
	FROM [Audit].[AuditEventTypes];
