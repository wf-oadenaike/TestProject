CREATE TABLE [Core].[RoleDepartmentRelationship] (
    [RoleId]             SMALLINT NOT NULL,
    [DepartmentId]       SMALLINT NOT NULL,
    [ActiveFlag]         BIT      CONSTRAINT [DF__RoleDepar__Activ__73A521EA] DEFAULT ((1)) NOT NULL,
    [ActiveFromDatetime] DATETIME CONSTRAINT [ActiveFromDatetimeDef] DEFAULT (getdate()) NOT NULL,
    [ActiveToDatetime]   DATETIME CONSTRAINT [ActiveToDatetimeDef] DEFAULT (getdate()) NOT NULL,
    [ControlId]          BIGINT   NULL,
    CONSTRAINT [PKRoleDepartmentRelationship] PRIMARY KEY CLUSTERED ([RoleId] ASC, [DepartmentId] ASC),
    CONSTRAINT [RoleDepartmentRelationshipDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [RoleDepartmentRelationshipRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

