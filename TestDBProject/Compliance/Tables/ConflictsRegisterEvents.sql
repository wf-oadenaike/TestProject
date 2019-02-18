CREATE TABLE [Compliance].[ConflictsRegisterEvents] (
    [ConflictsRegisterEventId]      INT              IDENTITY (1, 1) NOT NULL,
    [ConflictRegisterIdBK]          INT              NOT NULL,
    [ConflictEventTypeId]           SMALLINT         NOT NULL,
    [EventDetails]                  VARCHAR (2048)   NULL,
    [EventDate]                     DATETIME         NULL,
    [EventTrueFalse]                BIT              NULL,
    [DocumentationFolderLink]       VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]           UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [ConflictEventCreationDate]     DATETIME         CONSTRAINT [DF_CONRE_CECD] DEFAULT (getdate()) NOT NULL,
    [ConflictEventLastModifiedDate] DATETIME         CONSTRAINT [DF_CONRE_CELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKConflictsRegisterEvents] PRIMARY KEY CLUSTERED ([ConflictRegisterIdBK] ASC, [ConflictEventTypeId] ASC, [ConflictEventCreationDate] ASC),
    CONSTRAINT [ConflictsRegisterEventsConflictEventTypeId] FOREIGN KEY ([ConflictEventTypeId]) REFERENCES [Compliance].[ConflictEventTypes] ([ConflictEventTypeId]),
    CONSTRAINT [ConflictsRegisterEventsConflictRegisterIdBK] FOREIGN KEY ([ConflictRegisterIdBK]) REFERENCES [Compliance].[ConflictsRegister] ([ConflictRegisterIdBK])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [XUKConflictsRegisterEvents]
    ON [Compliance].[ConflictsRegisterEvents]([ConflictsRegisterEventId] ASC);

