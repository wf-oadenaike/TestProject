CREATE TABLE [Compliance].[StopListEventTypes] (
    [StopListEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [StopListEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKStopListEventTypes] PRIMARY KEY CLUSTERED ([StopListEventTypeId] ASC)
);

