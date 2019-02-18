CREATE TABLE [Organisation].[DepartmentalDefaultPA] (
    [DepartmentId]      SMALLINT NOT NULL,
    [DefaultPAPersonId] SMALLINT NOT NULL,
    [CreatedDate]       DATETIME CONSTRAINT [DF_DDP_CD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKDepartmentalDefaultPA] PRIMARY KEY CLUSTERED ([DepartmentId] ASC),
    CONSTRAINT [DepartmentalDefaultPADefaultPAPersonId] FOREIGN KEY ([DefaultPAPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [DepartmentalDefaultPADepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId])
);

