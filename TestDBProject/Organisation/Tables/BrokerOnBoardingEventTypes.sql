CREATE TABLE [Organisation].[BrokerOnBoardingEventTypes] (
    [BrokerOnBoardingEventTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [BrokerOnBoardingEventTypeBK]      VARCHAR (25)  NOT NULL,
    [BrokerOnBoardingEventDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKBrokerOnBoardingEventTypes] PRIMARY KEY CLUSTERED ([BrokerOnBoardingEventTypeBK] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIBrokerOnBoardingEventTypes]
    ON [Organisation].[BrokerOnBoardingEventTypes]([BrokerOnBoardingEventTypeId] ASC) WITH (FILLFACTOR = 90);

