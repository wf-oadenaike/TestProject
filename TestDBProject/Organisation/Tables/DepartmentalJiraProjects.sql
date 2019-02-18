CREATE TABLE [Organisation].[DepartmentalJiraProjects] (
    [DepartmentId]                  SMALLINT     NOT NULL,
    [DepartmentalJiraProjectTypeId] SMALLINT     NOT NULL,
    [ProjectKey]                    VARCHAR (31) NOT NULL,
    [CreatedDate]                   DATETIME     CONSTRAINT [DF_DJP_CD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKDepartmentalJiraProjects] PRIMARY KEY CLUSTERED ([DepartmentId] ASC, [DepartmentalJiraProjectTypeId] ASC),
    CONSTRAINT [DepartmentalJiraProjectsDepartmentalJiraProjectTypeId] FOREIGN KEY ([DepartmentalJiraProjectTypeId]) REFERENCES [Organisation].[DepartmentalJiraProjectTypes] ([DepartmentalJiraProjectTypeId]),
    CONSTRAINT [DepartmentalJiraProjectsDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId])
);

