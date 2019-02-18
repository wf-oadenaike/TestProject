CREATE TABLE [Compliance].[EBIRegisterEvents] (
    [EBIRegisterEventId]           INT              IDENTITY (1, 1) NOT NULL,
    [EBIRegisterId]                INT              NOT NULL,
    [EBIEventTypeId]               SMALLINT         NOT NULL,
    [EventDetails]                 NVARCHAR (MAX)   NULL,
    [EventDate]                    DATETIME         NULL,
    [EventTrueFalse]               BIT              NULL,
    [RecordedByPersonId]           SMALLINT         NOT NULL,
    [DocumentationFolderLink]      VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]          UNIQUEIDENTIFIER NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [EBIEventCreationDatetime]     DATETIME         CONSTRAINT [DF_EBIRE_EBIECDT] DEFAULT (getdate()) NOT NULL,
    [EBIEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_EBIRE_EBIELMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKEBIRegisterEvents] PRIMARY KEY CLUSTERED ([EBIRegisterId] ASC, [EBIEventTypeId] ASC, [EBIEventCreationDatetime] ASC),
    CONSTRAINT [EBIRegisterEventsEBIRegisterId] FOREIGN KEY ([EBIRegisterId]) REFERENCES [Compliance].[EBIRegister] ([EBIRegisterId]),
    CONSTRAINT [EBIRegisterEventsEventTypeId] FOREIGN KEY ([EBIEventTypeId]) REFERENCES [Compliance].[EBIRegisterEventTypes] ([EBIEventTypeId]),
    CONSTRAINT [EBIRegisterEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIEBIRegisterEvents]
    ON [Compliance].[EBIRegisterEvents]([EBIRegisterEventId] ASC);

