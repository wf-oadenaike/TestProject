CREATE TABLE [Sales].[ClientBillingStatuses] (
    [ClientBillingStatusId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ClientBillingStatus]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKClientBillingStatuses] PRIMARY KEY CLUSTERED ([ClientBillingStatusId] ASC)
);

