CREATE TABLE [Compliance].[ConflictsRegisterCategories] (
    [ConflictsRegisterCategoryId]          SMALLINT       IDENTITY (1, 1) NOT NULL,
    [ConflictsRegisterCategory]            NVARCHAR (255) NOT NULL,
    [ConflictsRegisterCategoryDescription] NVARCHAR (MAX) NULL,
    [CreationDate]                         DATETIME       CONSTRAINT [DF_CRC2_CDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKConflictsRegisterCategories] PRIMARY KEY CLUSTERED ([ConflictsRegisterCategoryId] ASC)
);

