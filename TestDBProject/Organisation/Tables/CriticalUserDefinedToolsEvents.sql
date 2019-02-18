CREATE TABLE [Organisation].[CriticalUserDefinedToolsEvents] (
    [EventId]                INT              IDENTITY (1, 1) NOT NULL,
    [ToolId]                 SMALLINT         NOT NULL,
    [EventDetails]           NVARCHAR (MAX)   NULL,
    [SubmittedByPersonId]    SMALLINT         NULL,
    [EventDate]              DATETIME         NOT NULL,
    [EventType]              NVARCHAR (255)   NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    CONSTRAINT [PKCriticalUserDefinedToolsEvents] PRIMARY KEY CLUSTERED ([EventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [UDTRSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [UDTRToolId] FOREIGN KEY ([ToolId]) REFERENCES [Organisation].[CriticalUserDefinedToolsRegister] ([ToolId])
);

