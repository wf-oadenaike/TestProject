CREATE TABLE [PolicyProc].[DocumentCategories] (
    [CategoryId]                INT           IDENTITY (1, 1) NOT NULL,
    [CategoryDescription]       VARCHAR (MAX) NULL,
    [DraftPolicyFolderId]       VARCHAR (255) NULL,
    [DraftProcedureFolderId]    VARCHAR (255) NULL,
    [LivePolicyFolderId]        VARCHAR (255) NULL,
    [LiveProcedureFolderId]     VARCHAR (255) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_DC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_DC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_DC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_DC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_DC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKDocumentCategories] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);

