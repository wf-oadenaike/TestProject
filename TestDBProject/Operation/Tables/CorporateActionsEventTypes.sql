CREATE TABLE [Operation].[CorporateActionsEventTypes] (
    [CorporateActionsEventTypeId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [CorporateActionsEventTypeName] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKCorporateActionsEventTypes] PRIMARY KEY CLUSTERED ([CorporateActionsEventTypeId] ASC)
);

