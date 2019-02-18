CREATE TABLE [Sales].[ClientBillingEventTypes] (
    [ClientBillingEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ClientBillingEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKClientBillingEventTypes] PRIMARY KEY CLUSTERED ([ClientBillingEventTypeId] ASC)
);

