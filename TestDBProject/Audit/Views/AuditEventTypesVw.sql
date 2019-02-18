CREATE VIEW [Audit].[AuditEventTypesVw]
	AS
	SELECT AuditEventTypeId, AuditEventTypeBK, AuditEventDescription
	FROM [Audit].[AuditEventTypes];
