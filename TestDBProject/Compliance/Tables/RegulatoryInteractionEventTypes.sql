CREATE TABLE [Compliance].[RegulatoryInteractionEventTypes] (
    [RegulatoryInteractionEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [RegulatoryInteractionEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKRegulatoryInteractionEventTypes] PRIMARY KEY CLUSTERED ([RegulatoryInteractionEventTypeId] ASC)
);

