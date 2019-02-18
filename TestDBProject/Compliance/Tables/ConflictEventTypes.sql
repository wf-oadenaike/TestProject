CREATE TABLE [Compliance].[ConflictEventTypes] (
    [ConflictEventTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ConflictEventTypeBK]      VARCHAR (25)  NOT NULL,
    [ConflictEventDescription] VARCHAR (100) NOT NULL,
    [ColSequence]              SMALLINT      NOT NULL,
    CONSTRAINT [XPKConflictEventTypes] PRIMARY KEY CLUSTERED ([ConflictEventTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUConflictEventTypes]
    ON [Compliance].[ConflictEventTypes]([ConflictEventTypeId] ASC);

