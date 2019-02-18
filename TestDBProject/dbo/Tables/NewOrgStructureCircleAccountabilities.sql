CREATE TABLE [dbo].[NewOrgStructureCircleAccountabilities] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [Description]            NVARCHAR (MAX) NULL,
    [CircleId]               SMALLINT       NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [IsActive]               BIT            DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80)
);

