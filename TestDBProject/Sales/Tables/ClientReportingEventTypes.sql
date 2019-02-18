CREATE TABLE [Sales].[ClientReportingEventTypes] (
    [ClientReportingEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ClientReportingEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKClientReportingEventTypes] PRIMARY KEY CLUSTERED ([ClientReportingEventTypeId] ASC)
);

