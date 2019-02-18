CREATE TABLE [Organisation].[MeetingAgendaItems] (
    [MeetingAgendaItemId]                   SMALLINT         IDENTITY (1, 1) NOT NULL,
    [MeetingRegisterId]                     SMALLINT         NOT NULL,
    [AgendaItemNameBK]                      [sysname]        NOT NULL,
    [AgendaItemDetails]                     VARCHAR (2048)   NOT NULL,
    [ReporterRoleId]                        SMALLINT         NOT NULL,
    [AssigneeRoleId]                        SMALLINT         NOT NULL,
    [IssueType]                             VARCHAR (128)    NOT NULL,
    [ActiveFlag]                            BIT              CONSTRAINT [DF_MAI_AF] DEFAULT ((1)) NOT NULL,
    [LagLead]                               SMALLINT         NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                   UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [MeetingAgendaItemCreationDatetime]     DATETIME         CONSTRAINT [DF_MAI_MAICDT] DEFAULT (getdate()) NOT NULL,
    [MeetingAgendaItemLastModifiedDatetime] DATETIME         CONSTRAINT [DF_MAI_MAILMDT] DEFAULT (getdate()) NOT NULL,
    [Frequency]                             VARCHAR (128)    NULL,
    [Purpose]                               VARCHAR (2048)   NULL,
    [Outcome]                               VARCHAR (2048)   NULL,
    CONSTRAINT [PKMeetingAgendaItems] PRIMARY KEY CLUSTERED ([MeetingRegisterId] ASC, [AgendaItemNameBK] ASC),
    CONSTRAINT [MeetingAgendaItemsAssigneeRoleId] FOREIGN KEY ([AssigneeRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [MeetingAgendaItemsMeetingRegisterId] FOREIGN KEY ([MeetingRegisterId]) REFERENCES [Organisation].[MeetingsRegister] ([MeetingRegisterId]),
    CONSTRAINT [MeetingAgendaItemsReporterRoleId] FOREIGN KEY ([ReporterRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIMeetingAgendaItems]
    ON [Organisation].[MeetingAgendaItems]([MeetingAgendaItemId] ASC);

