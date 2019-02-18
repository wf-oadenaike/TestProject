CREATE TABLE [Organisation].[CircleAccountabilities] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [Description]            NVARCHAR (MAX) NULL,
    [CircleId]               SMALLINT       NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80)
);

