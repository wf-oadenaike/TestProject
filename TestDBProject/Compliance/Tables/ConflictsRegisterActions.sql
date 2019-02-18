CREATE TABLE [Compliance].[ConflictsRegisterActions] (
    [ConflictsRegisterActionId] INT           IDENTITY (1, 1) NOT NULL,
    [ConflictId]                INT           NOT NULL,
    [ActionTypeId]              SMALLINT      NOT NULL,
    [ActionDate]                DATETIME      NOT NULL,
    [ActionComment]             VARCHAR (MAX) NULL,
    [CreatedByPersonId]         SMALLINT      NOT NULL,
    [CreationDate]              DATETIME      CONSTRAINT [DF_CRA_CDT] DEFAULT (getdate()) NOT NULL,
    [JIRAIssueKey]              VARCHAR (255) NULL,
    [IsActive]                  BIT           DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKConflictsRegisterActions] PRIMARY KEY CLUSTERED ([ConflictsRegisterActionId] ASC),
    CONSTRAINT [ConflictsRegisterActionsActionTypeId] FOREIGN KEY ([ActionTypeId]) REFERENCES [Compliance].[ConflictsRegisterActionTypes] ([ActionTypeId]),
    CONSTRAINT [ConflictsRegisterActionsConflictId] FOREIGN KEY ([ConflictId]) REFERENCES [Compliance].[ConflictsRegisterPotential] ([ConflictId]),
    CONSTRAINT [ConflictsRegisterActionsCreatedByPersionId] FOREIGN KEY ([CreatedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

