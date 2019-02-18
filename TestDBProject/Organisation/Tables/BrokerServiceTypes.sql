CREATE TABLE [Organisation].[BrokerServiceTypes] (
    [ServiceTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [ServiceType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKBrokerServiceTypes] PRIMARY KEY CLUSTERED ([ServiceTypeId] ASC)
);

