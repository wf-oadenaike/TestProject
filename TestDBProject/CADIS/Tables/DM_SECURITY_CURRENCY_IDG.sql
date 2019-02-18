﻿CREATE TABLE [CADIS].[DM_SECURITY_CURRENCY_IDG] (
    [CCY_CODE]               VARCHAR (20)  NOT NULL,
    [CADISID]                INT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([CCY_CODE] ASC)
);
