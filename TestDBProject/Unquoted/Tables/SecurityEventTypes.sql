CREATE TABLE [Unquoted].[SecurityEventTypes] (
    [SecurityEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [SecurityEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKSecurityEventTypes] PRIMARY KEY CLUSTERED ([SecurityEventTypeId] ASC)
);

