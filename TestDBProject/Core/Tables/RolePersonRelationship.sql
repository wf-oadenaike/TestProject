CREATE TABLE [Core].[RolePersonRelationship] (
    [RoleId]             SMALLINT NOT NULL,
    [PersonId]           SMALLINT NOT NULL,
    [ActiveFlag]         BIT      NOT NULL,
    [ActiveFromDatetime] DATETIME NOT NULL,
    [ActiveToDatetime]   DATETIME NOT NULL,
    [ControlId]          BIGINT   NULL,
    CONSTRAINT [PKRolePersonRelationship] PRIMARY KEY CLUSTERED ([RoleId] ASC, [PersonId] ASC, [ActiveFromDatetime] ASC),
    CONSTRAINT [RolePersonRelationshipPersonId] FOREIGN KEY ([PersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RolePersonRelationshipRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

