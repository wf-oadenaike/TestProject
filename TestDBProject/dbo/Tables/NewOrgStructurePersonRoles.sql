CREATE TABLE [dbo].[NewOrgStructurePersonRoles] (
    [Id]                     INT           IDENTITY (1, 1) NOT NULL,
    [RoleId]                 SMALLINT      NOT NULL,
    [PersonId]               SMALLINT      NOT NULL,
    [CircleId]               SMALLINT      NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80)
);

