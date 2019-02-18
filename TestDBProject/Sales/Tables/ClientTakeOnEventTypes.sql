CREATE TABLE [Sales].[ClientTakeOnEventTypes] (
    [ClientTakeOnEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ClientTakeOnEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKClientTakeOnEventTypes] PRIMARY KEY CLUSTERED ([ClientTakeOnEventTypeId] ASC)
);

