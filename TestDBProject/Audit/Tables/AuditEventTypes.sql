CREATE TABLE [Audit].[AuditEventTypes] (
    [AuditEventTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [AuditEventTypeBK]      VARCHAR (25)  NOT NULL,
    [AuditEventDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [XPKAuditEventTypes] PRIMARY KEY CLUSTERED ([AuditEventTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUAuditEventTypes]
    ON [Audit].[AuditEventTypes]([AuditEventTypeId] ASC);

