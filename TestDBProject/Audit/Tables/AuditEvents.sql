CREATE TABLE [Audit].[AuditEvents] (
    [AuditEventId]        INT              IDENTITY (1, 1) NOT NULL,
    [WorkflowVersionGUID] UNIQUEIDENTIFIER CONSTRAINT [DF_AR_WVG] DEFAULT (newid()) NOT NULL,
    [JoinGUID]            UNIQUEIDENTIFIER CONSTRAINT [DF_AR_JG] DEFAULT (newid()) NOT NULL,
    [AuditEventTypeId]    SMALLINT         NOT NULL,
    [EventDescription]    VARCHAR (2048)   NOT NULL,
    [EventDatetime]       DATETIME         CONSTRAINT [DF_AR_EDT] DEFAULT (getdate()) NOT NULL,
    [BeforeImage]         VARCHAR (MAX)    NULL,
    [AfterImage]          VARCHAR (MAX)    NULL,
    CONSTRAINT [XPKAuditEvents] PRIMARY KEY CLUSTERED ([WorkflowVersionGUID] ASC, [JoinGUID] ASC, [EventDatetime] ASC),
    CONSTRAINT [AuditEventsAuditEventTypeId] FOREIGN KEY ([AuditEventTypeId]) REFERENCES [Audit].[AuditEventTypes] ([AuditEventTypeId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUAuditEvents]
    ON [Audit].[AuditEvents]([AuditEventId] ASC);

