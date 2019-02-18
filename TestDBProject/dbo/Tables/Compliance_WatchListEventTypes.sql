CREATE TABLE [dbo].[Compliance_WatchListEventTypes] (
    [WatchListEventTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [WatchListEventType]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PKWatchListEventTypes] PRIMARY KEY CLUSTERED ([WatchListEventTypeId] ASC) WITH (FILLFACTOR = 80)
);

