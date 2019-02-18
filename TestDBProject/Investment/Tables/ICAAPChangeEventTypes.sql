CREATE TABLE [Investment].[ICAAPChangeEventTypes] (
    [ICAAPChangeEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ICAAPChangeEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKICAAPChangeEventTypes] PRIMARY KEY CLUSTERED ([ICAAPChangeEventTypeId] ASC)
);

