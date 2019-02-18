﻿CREATE TABLE [CADIS].[DM_PARTY_BBG_BROKER_IDG] (
    [BROKER]                 VARCHAR (40)  NOT NULL,
    [CADISID]                INT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([BROKER] ASC)
);
