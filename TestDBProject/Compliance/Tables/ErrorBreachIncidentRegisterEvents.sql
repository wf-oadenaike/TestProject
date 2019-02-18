CREATE TABLE [Compliance].[ErrorBreachIncidentRegisterEvents] (
    [EBIRegisterEventId]       INT              IDENTITY (1, 1) NOT NULL,
    [EBIRegisterIdBK]          INT              NOT NULL,
    [EBIEventTypeId]           SMALLINT         NOT NULL,
    [EventDetails]             VARCHAR (2048)   NULL,
    [EventDate]                DATETIME         NULL,
    [EventTrueFalse]           BIT              NULL,
    [RecordedByPersonId]       SMALLINT         NOT NULL,
    [DocumentationFolderLink]  VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]      UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                 UNIQUEIDENTIFIER NOT NULL,
    [EBIEventCreationDate]     DATETIME         CONSTRAINT [DF_EBIRE_EBIECD] DEFAULT (getdate()) NOT NULL,
    [EBIEventLastModifiedDate] DATETIME         CONSTRAINT [DF_EBIRE_EBIELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKErrorBreachIncidentRegisterEvents] PRIMARY KEY CLUSTERED ([EBIRegisterIdBK] ASC, [EBIEventTypeId] ASC, [EBIEventCreationDate] ASC),
    CONSTRAINT [ErrorBreachIncidentRegisterEventsEBIRegisterIdBK] FOREIGN KEY ([EBIRegisterIdBK]) REFERENCES [Compliance].[ErrorBreachIncidentRegister] ([EBIRegisterIdBK]),
    CONSTRAINT [ErrorBreachIncidentRegisterEventsEventTypeId] FOREIGN KEY ([EBIEventTypeId]) REFERENCES [Compliance].[ErrorBreachIncidentRegisterEventTypes] ([EBIEventTypeId]),
    CONSTRAINT [ErrorBreachIncidentRegisterEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [XUKErrorBreachIncidentRegisterEvents]
    ON [Compliance].[ErrorBreachIncidentRegisterEvents]([EBIRegisterEventId] ASC);

