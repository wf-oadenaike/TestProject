CREATE TABLE [Compliance].[ConflictsRegisterMitigation] (
    [ConflictId]                    INT            NOT NULL,
    [MitigationDetails]             NVARCHAR (MAX) NOT NULL,
    [CreatedByPersionId]            SMALLINT       NOT NULL,
    [CreationDate]                  DATETIME       CONSTRAINT [DF_CRM_CDT] DEFAULT (getdate()) NOT NULL,
    [ConflictsRegisterMitigationID] INT            IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PKConflictsRegisterMitigation] PRIMARY KEY CLUSTERED ([ConflictsRegisterMitigationID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [ConflictsMitigationsCreatedByPersionId] FOREIGN KEY ([CreatedByPersionId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ConflictsRegisterMitigationConflictId] FOREIGN KEY ([ConflictId]) REFERENCES [Compliance].[ConflictsRegisterPotential] ([ConflictId])
);

