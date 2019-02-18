﻿CREATE TABLE [KPI].[KPIGroups] (
    [KPIGroupId]                SMALLINT      IDENTITY (1, 1) NOT NULL,
    [KPIGroupName]              VARCHAR (128) NOT NULL,
    [KPIGroupDescription]       VARCHAR (128) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_KPIG_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_KPIG_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_KPIG_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_KPIG_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_KPIG_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKKPIGroups] PRIMARY KEY CLUSTERED ([KPIGroupName] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIKPIGroups]
    ON [KPI].[KPIGroups]([KPIGroupId] ASC);
