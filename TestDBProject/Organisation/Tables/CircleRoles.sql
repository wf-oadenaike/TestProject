CREATE TABLE [Organisation].[CircleRoles] (
    [RoleId]                 SMALLINT       IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (100) NULL,
    [Purpose]                NVARCHAR (MAX) NULL,
    [ParentCircleId]         SMALLINT       NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CoreRoleFlag]           BIT            DEFAULT ((0)) NULL,
    [FocusArea]              NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([RoleId] ASC) WITH (FILLFACTOR = 80)
);

