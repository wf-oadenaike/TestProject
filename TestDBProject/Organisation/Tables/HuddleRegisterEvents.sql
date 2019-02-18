CREATE TABLE [Organisation].[HuddleRegisterEvents] (
    [EventId]                INT              IDENTITY (1, 1) NOT NULL,
    [HuddleEventId]          INT              NOT NULL,
    [EventTypeId]            SMALLINT         NOT NULL,
    [SubmittedByPersonId]    SMALLINT         NOT NULL,
    [EventDate]              DATETIME         NOT NULL,
    [EventDetails]           NVARCHAR (MAX)   NULL,
    [JiraIssueKey]           NVARCHAR (50)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKHuddleRegisterEvents] PRIMARY KEY CLUSTERED ([EventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [HEEventTypeId] FOREIGN KEY ([EventTypeId]) REFERENCES [Organisation].[HuddleRegisterEventTypes] ([EventTypeId]),
    CONSTRAINT [HEHuddleEventId] FOREIGN KEY ([HuddleEventId]) REFERENCES [Organisation].[HuddleEvents] ([EventId]),
    CONSTRAINT [HESubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

