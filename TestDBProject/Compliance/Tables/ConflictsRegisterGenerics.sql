CREATE TABLE [Compliance].[ConflictsRegisterGenerics] (
    [ConflictsRegisterGenericId] SMALLINT        IDENTITY (1, 1) NOT NULL,
    [GenericConflictTitle]       NVARCHAR (2000) NOT NULL,
    [GenericConflictDetails]     NVARCHAR (MAX)  NOT NULL,
    [CreatedByPersonId]          SMALLINT        NOT NULL,
    [CreationDate]               DATETIME        CONSTRAINT [DF_CRG_CDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKConflictsRegisterGenerics] PRIMARY KEY CLUSTERED ([ConflictsRegisterGenericId] ASC),
    CONSTRAINT [ConflictsRegisterGenericsCreatedByPersionId] FOREIGN KEY ([CreatedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

