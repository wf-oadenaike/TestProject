CREATE TABLE [dbo].[NewOrgStructureChangeType] (
    [ChangeTypeId]           INT           IDENTITY (1, 1) NOT NULL,
    [ChangeTypeName]         VARCHAR (100) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKNewOrgStructureChangeType] PRIMARY KEY CLUSTERED ([ChangeTypeId] ASC) WITH (FILLFACTOR = 80)
);

