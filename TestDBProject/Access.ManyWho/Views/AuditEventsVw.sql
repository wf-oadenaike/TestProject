CREATE VIEW [Access.ManyWho].[AuditEventsVw]
	AS
	SELECT AuditEventId,
	WorkflowVersionGUID,
	JoinGUID,
    AuditEventTypeId,
    EventDescription,
    EventDatetime,
	BeforeImage,
	AfterImage
	FROM [Audit].[AuditEvents]
	;
