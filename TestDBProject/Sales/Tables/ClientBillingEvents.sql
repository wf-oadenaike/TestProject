CREATE TABLE [Sales].[ClientBillingEvents] (
    [ClientBillingEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ClientBillingId]                        INT              NOT NULL,
    [EventTypeId]                            SMALLINT         NOT NULL,
    [SubmittedByPersonId]                    SMALLINT         CONSTRAINT [DF_CBE_CBESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                           VARCHAR (MAX)    NULL,
    [EventDate]                              DATETIME         CONSTRAINT [DF_CBE_CBEED] DEFAULT (getdate()) NOT NULL,
    [EventTrueFalse]                         BIT              NULL,
    [DocumentationFolderLink]                VARCHAR (2000)   NULL,
    [JoinGUID]                               UNIQUEIDENTIFIER NOT NULL,
    [ClientBillingEventCreationDate]         DATETIME         CONSTRAINT [DF_CBE_CBECD] DEFAULT (getdate()) NOT NULL,
    [ClientBillingEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CBE_CBELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKClientBillingEvents] PRIMARY KEY CLUSTERED ([ClientBillingEventId] ASC),
    CONSTRAINT [ClientBillingEventsClientBillingId] FOREIGN KEY ([ClientBillingId]) REFERENCES [Sales].[ClientBilling] ([ClientBillingId]),
    CONSTRAINT [ClientBillingEventsEventTypeId] FOREIGN KEY ([EventTypeId]) REFERENCES [Sales].[ClientBillingEventTypes] ([ClientBillingEventTypeId]),
    CONSTRAINT [ClientBillingEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

