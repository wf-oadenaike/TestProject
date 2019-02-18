CREATE TABLE [Compliance].[ConflictsRegisterUserInteractions] (
    [ConflictsRegisterUserInteractionId] INT              IDENTITY (1, 1) NOT NULL,
    [ConflictId]                         INT              NOT NULL,
    [UserInteractionTypeId]              SMALLINT         NOT NULL,
    [InteractionMessage]                 NVARCHAR (MAX)   NOT NULL,
    [InteractionDate]                    DATETIME         CONSTRAINT [DF_CRUI_IDT] DEFAULT (getdate()) NOT NULL,
    [WorkflowVersionGUID]                UNIQUEIDENTIFIER NULL,
    [JoinGUID]                           UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [XPKConflictsRegisterUserInteractionId] PRIMARY KEY CLUSTERED ([ConflictsRegisterUserInteractionId] ASC),
    CONSTRAINT [ConflictsRegisterUserInteractionsConflictId] FOREIGN KEY ([ConflictId]) REFERENCES [Compliance].[ConflictsRegisterPotential] ([ConflictId])
);

