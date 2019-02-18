CREATE TABLE [Compliance].[PADealingEventTypes] (
    [PADealingEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [PADealingEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKPADealingEventTypes] PRIMARY KEY CLUSTERED ([PADealingEventTypeId] ASC)
);

