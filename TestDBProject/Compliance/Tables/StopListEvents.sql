CREATE TABLE [Compliance].[StopListEvents] (
    [StopListEventId]        INT              IDENTITY (1, 1) NOT NULL,
    [StopListReasonId]       INT              NOT NULL,
    [EventDetails]           VARCHAR (MAX)    NULL,
    [StopListStatusId]       SMALLINT         NOT NULL,
    [EventDate]              DATETIME         NULL,
    [SubmittedByPersonId]    SMALLINT         NOT NULL,
    [JIRAIssueKey]           VARCHAR (255)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    CONSTRAINT [PKtmpStopListEvents] PRIMARY KEY CLUSTERED ([StopListEventId] ASC) WITH (FILLFACTOR = 80)
);

