CREATE TABLE [Investment].[ShareClassWaiverEventTypes] (
    [ShareClassWaiverEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ShareClassWaiverEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKShareClassWaiverEventTypes] PRIMARY KEY CLUSTERED ([ShareClassWaiverEventTypeId] ASC)
);

