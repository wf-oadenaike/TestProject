CREATE TABLE [Internal.Audit].[AuditPlanEvents] (
    [AuditPlanEventId]               INT              IDENTITY (1, 1) NOT NULL,
    [AuditPlanRegisterId]            INT              NOT NULL,
    [AuditPlanEventType]             VARCHAR (128)    NOT NULL,
    [EventPersonId]                  SMALLINT         NOT NULL,
    [EventRoleId]                    SMALLINT         NOT NULL,
    [EventTrueFalse]                 BIT              NULL,
    [EventDetails]                   VARCHAR (2048)   NULL,
    [EventDate]                      DATETIME         NULL,
    [DocumentationFolderLink]        VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]            UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                       UNIQUEIDENTIFIER NOT NULL,
    [AuditPlanEventCreationDate]     DATETIME         CONSTRAINT [DF_APE_APECD] DEFAULT (getdate()) NOT NULL,
    [AuditPlanEventLastModifiedDate] DATETIME         CONSTRAINT [DF_APE_APELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKAuditPlanEvents] PRIMARY KEY CLUSTERED ([AuditPlanRegisterId] ASC, [AuditPlanEventType] ASC),
    CONSTRAINT [AuditPlanEventsPersonId] FOREIGN KEY ([EventPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [AuditPlanEventsRoleId] FOREIGN KEY ([EventRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [AuditPlanRegisterId] FOREIGN KEY ([AuditPlanRegisterId]) REFERENCES [Internal.Audit].[AuditPlanRegister] ([AuditPlanRegisterId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [XUKAuditPlanEvents]
    ON [Internal.Audit].[AuditPlanEvents]([AuditPlanEventId] ASC);

