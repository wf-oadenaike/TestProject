CREATE TABLE [dbo].[NewOrgStructureReviewType] (
    [ReviewTypeId]           INT           IDENTITY (1, 1) NOT NULL,
    [ReviewTypeName]         VARCHAR (100) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKNewOrgStructureReviewType] PRIMARY KEY CLUSTERED ([ReviewTypeId] ASC) WITH (FILLFACTOR = 80)
);

