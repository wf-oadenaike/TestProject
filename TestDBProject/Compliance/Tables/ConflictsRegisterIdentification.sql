CREATE TABLE [Compliance].[ConflictsRegisterIdentification] (
    [ConflictId]                   INT            NOT NULL,
    [ConflictsRegisterGenericId]   SMALLINT       NULL,
    [ConflictIdentifier]           AS             (((right(CONVERT([varchar](4),datepart(year,getdate())),(2))+'C')+CONVERT([varchar](4),[ConflictId]))+case when [ConflictsRegisterGenericId] IS NOT NULL then '.'+right('0'+CONVERT([varchar](2),[ConflictsRegisterGenericId]),(2)) else '' end),
    [ConflictIdentifierOverride]   VARCHAR (15)   NULL,
    [ConflictsRegisterCategoryId1] SMALLINT       NOT NULL,
    [ConflictsRegisterCategoryId2] SMALLINT       NULL,
    [DocumentationFolderUrl]       VARCHAR (2083) NULL,
    [CreatedByPersionId]           SMALLINT       NOT NULL,
    [CreationDate]                 DATETIME       CONSTRAINT [DF_CRI_CDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKConflictsRegisterIdentification] PRIMARY KEY CLUSTERED ([ConflictId] ASC),
    CONSTRAINT [ConflictsRegisterIdentificationConflictId] FOREIGN KEY ([ConflictId]) REFERENCES [Compliance].[ConflictsRegisterPotential] ([ConflictId]),
    CONSTRAINT [ConflictsRegisterIdentificationConflictsRegisterCategoryId1] FOREIGN KEY ([ConflictsRegisterCategoryId1]) REFERENCES [Compliance].[ConflictsRegisterCategories] ([ConflictsRegisterCategoryId]),
    CONSTRAINT [ConflictsRegisterIdentificationConflictsRegisterCategoryId2] FOREIGN KEY ([ConflictsRegisterCategoryId2]) REFERENCES [Compliance].[ConflictsRegisterCategories] ([ConflictsRegisterCategoryId]),
    CONSTRAINT [ConflictsRegisterIdentificationConflictsRegisterGenericId] FOREIGN KEY ([ConflictsRegisterGenericId]) REFERENCES [Compliance].[ConflictsRegisterGenerics] ([ConflictsRegisterGenericId])
);

