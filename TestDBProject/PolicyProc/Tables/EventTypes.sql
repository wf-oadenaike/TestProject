CREATE TABLE [PolicyProc].[EventTypes] (
    [EventTypeId] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [EventType]   VARCHAR (25) NOT NULL,
    CONSTRAINT [PKEventTypes] PRIMARY KEY CLUSTERED ([EventTypeId] ASC)
);

