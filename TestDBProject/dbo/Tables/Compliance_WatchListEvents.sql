CREATE TABLE [dbo].[Compliance_WatchListEvents] (
    [WatchlistEventId]       INT              IDENTITY (1, 1) NOT NULL,
    [WatchlistRegisterId]    INT              NOT NULL,
    [EventTypeid]            INT              NOT NULL,
    [EventDetails]           VARCHAR (MAX)    NULL,
    [SubmittedByPersonId]    SMALLINT         NOT NULL,
    [EventDate]              DATETIME         CONSTRAINT [T_WLRE_ED] DEFAULT (getdate()) NULL,
    [EventTrueFalse]         BIT              NULL,
    [JiraIssueKey]           VARCHAR (128)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         CONSTRAINT [T_WLRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         CONSTRAINT [T_WLRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    CONSTRAINT [T_WLRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKWatchListEvents] PRIMARY KEY CLUSTERED ([WatchlistEventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [WatchListEventsEventTypeid] FOREIGN KEY ([EventTypeid]) REFERENCES [dbo].[Compliance_WatchListEventTypes] ([WatchListEventTypeId]),
    CONSTRAINT [WatchListEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [WatchListEventsWatchlistRegisterId] FOREIGN KEY ([WatchlistRegisterId]) REFERENCES [dbo].[Compliance_WatchListRegister] ([WatchListRegisterId])
);

