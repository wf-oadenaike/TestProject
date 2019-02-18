CREATE TABLE [Organisation].[ProjectAspects] (
    [ProjectAspectId]                   SMALLINT         IDENTITY (1, 1) NOT NULL,
    [ProjectRegisterId]                 SMALLINT         NOT NULL,
    [ProjectAspectTypeId]               SMALLINT         NOT NULL,
    [Costs]                             DECIMAL (19, 5)  NULL,
    [PersonId]                          SMALLINT         CONSTRAINT [DF_PA_PI] DEFAULT ((-1)) NULL,
    [RoleId]                            SMALLINT         CONSTRAINT [DF_PA_RI] DEFAULT ((-1)) NULL,
    [DepartmentId]                      SMALLINT         CONSTRAINT [DF_PA_DI] DEFAULT ((-1)) NULL,
    [AspectDetails]                     VARCHAR (2048)   NULL,
    [AspectDate]                        DATETIME         NULL,
    [AspectTrueFalse]                   BIT              NULL,
    [DocumentationFolderLink]           VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]               UNIQUEIDENTIFIER CONSTRAINT [DF_PA_WVG] DEFAULT (newid()) NOT NULL,
    [JoinGUID]                          UNIQUEIDENTIFIER CONSTRAINT [DF_PA_JG] DEFAULT (newid()) NOT NULL,
    [ProjectAspectCreationDatetime]     DATETIME         CONSTRAINT [DF_PA_PACDT] DEFAULT (getdate()) NOT NULL,
    [ProjectAspectLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PA_PALMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKProjectAspects] PRIMARY KEY CLUSTERED ([ProjectRegisterId] ASC, [ProjectAspectTypeId] ASC, [ProjectAspectId] ASC),
    CONSTRAINT [ProjectAspectsAspectTypeId] FOREIGN KEY ([ProjectAspectTypeId]) REFERENCES [Organisation].[ProjectAspectTypes] ([ProjectAspectTypeId]),
    CONSTRAINT [ProjectAspectsDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [ProjectAspectsPersonId] FOREIGN KEY ([PersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ProjectAspectsProjectRegisterId] FOREIGN KEY ([ProjectRegisterId]) REFERENCES [Organisation].[ProjectsRegister] ([ProjectRegisterId]),
    CONSTRAINT [ProjectAspectsRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXProjectAspects]
    ON [Organisation].[ProjectAspects]([ProjectAspectId] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIX1ProjectAspects]
    ON [Organisation].[ProjectAspects]([ProjectRegisterId] ASC, [ProjectAspectTypeId] ASC, [PersonId] ASC, [RoleId] ASC, [DepartmentId] ASC);

