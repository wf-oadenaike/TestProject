﻿CREATE TABLE [Risk].[RiskImpact] (
    [RiskImpactId]              SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ImpactName]                VARCHAR (25)  NOT NULL,
    [ImpactScore]               SMALLINT      NOT NULL,
    [CreatedDate]               DATETIME      CONSTRAINT [DT_RI_CDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_RI_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_RI_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_RI_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_RI_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_RI_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRiskImpact] PRIMARY KEY CLUSTERED ([RiskImpactId] ASC)
);
