CREATE TABLE [Organisation].[WhistleblowingEventTypes] (
    [WhistleblowingEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [WhistleblowingEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKWhistleblowingEventTypes] PRIMARY KEY CLUSTERED ([WhistleblowingEventTypeId] ASC)
);

