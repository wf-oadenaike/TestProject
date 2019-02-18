CREATE TABLE [Sales].[ClientReportingEvents] (
    [ClientReportingEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ClientReportingId]                        INT              NOT NULL,
    [EventTypeId]                              SMALLINT         NOT NULL,
    [SubmittedByPersonId]                      SMALLINT         CONSTRAINT [DF_CRE_CRESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                             VARCHAR (MAX)    NULL,
    [EventDate]                                DATETIME         CONSTRAINT [DF_CRE_CREED] DEFAULT (getdate()) NOT NULL,
    [EventTrueFalse]                           BIT              NULL,
    [DocumentationFolderLink]                  VARCHAR (2000)   NULL,
    [JoinGUID]                                 UNIQUEIDENTIFIER NOT NULL,
    [ClientReportingEventCreationDate]         DATETIME         CONSTRAINT [DF_CRE_CRECD] DEFAULT (getdate()) NOT NULL,
    [ClientReportingEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CRE_CRELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKClientReportingEvents] PRIMARY KEY CLUSTERED ([ClientReportingEventId] ASC),
    CONSTRAINT [ClientReportingEventsClientReportingId] FOREIGN KEY ([ClientReportingId]) REFERENCES [Sales].[ClientReporting] ([ClientReportingId]),
    CONSTRAINT [ClientReportingEventsEventTypeId] FOREIGN KEY ([EventTypeId]) REFERENCES [Sales].[ClientReportingEventTypes] ([ClientReportingEventTypeId]),
    CONSTRAINT [ClientReportingEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

