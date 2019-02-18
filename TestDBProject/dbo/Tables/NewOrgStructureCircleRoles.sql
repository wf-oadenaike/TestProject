CREATE TABLE [dbo].[NewOrgStructureCircleRoles] (
    [RoleId]                 SMALLINT      NOT NULL,
    [CircleId]               SMALLINT      NOT NULL,
    [RoleFillers]            SMALLINT      NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC, [CircleId] ASC) WITH (FILLFACTOR = 80)
);

