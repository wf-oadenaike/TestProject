CREATE TABLE [Product.Governance].[ProductGovStages] (
    [ProductGovStageId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ProductGovRegisterId]                INT              NOT NULL,
    [StageCategoryId]                     SMALLINT         NOT NULL,
    [SectionName]                         VARCHAR (128)    NOT NULL,
    [OwnerPersonId]                       SMALLINT         CONSTRAINT [DF_PGS_OPI] DEFAULT ((-1)) NOT NULL,
    [OwnerRoleId]                         SMALLINT         CONSTRAINT [DF_PGS_ORI] DEFAULT ((-1)) NOT NULL,
    [StageCompletionDate]                 DATETIME         NULL,
    [JIRAEpicKey]                         VARCHAR (2000)   NULL,
    [DocumentationFolderLink]             VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                 UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                            UNIQUEIDENTIFIER NOT NULL,
    [ProductGovStageCreationDatetime]     DATETIME         CONSTRAINT [DF_PGS_PGSCDT] DEFAULT (getdate()) NOT NULL,
    [ProductGovStageLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PGS_PGSLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKProductGovStages] PRIMARY KEY CLUSTERED ([ProductGovRegisterId] ASC, [StageCategoryId] ASC),
    CONSTRAINT [ProductGovStagesCategoryId] FOREIGN KEY ([StageCategoryId]) REFERENCES [Product.Governance].[ProductGovStageCategories] ([StageCategoryId]),
    CONSTRAINT [ProductGovStagesOwnerPersonId] FOREIGN KEY ([OwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ProductGovStagesOwnerRoleId] FOREIGN KEY ([OwnerRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProductGovStages]
    ON [Product.Governance].[ProductGovStages]([ProductGovStageId] ASC);

