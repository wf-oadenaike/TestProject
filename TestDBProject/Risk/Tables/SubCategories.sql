﻿CREATE TABLE [Risk].[SubCategories] (
    [SubCategoryId]             SMALLINT       IDENTITY (1, 1) NOT NULL,
    [CategoryId]                SMALLINT       NOT NULL,
    [SubCategory]               NVARCHAR (127) NOT NULL,
    [RiskAppetite]              NVARCHAR (25)  NULL,
    [CreatedDate]               DATETIME       CONSTRAINT [DT_SC_CDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF_SC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF_SC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF_SC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF_SC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF_SC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKSubCategoryId] PRIMARY KEY CLUSTERED ([SubCategoryId] ASC),
    CONSTRAINT [SubCategoriesCategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Risk].[Categories] ([CategoryId])
);

