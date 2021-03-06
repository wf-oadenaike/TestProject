﻿CREATE TABLE [Risk].[Categories] (
    [CategoryId]                SMALLINT       IDENTITY (1, 1) NOT NULL,
    [Category]                  NVARCHAR (127) NOT NULL,
    [CreatedDate]               DATETIME       CONSTRAINT [DT_C_CDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF_C_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF_C_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF_C_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF_C_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF_C_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKCategoryId] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
);

