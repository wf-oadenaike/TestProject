﻿CREATE TABLE [Risk].[RiskRegisterEventTypes] (
    [RiskEventTypeID]           INT           NOT NULL,
    [RiskEventType]             VARCHAR (25)  NOT NULL,
    [RiskEventTypeCreationDate] DATETIME      CONSTRAINT [DF_RRET_RETCD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_RRET_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_RRET_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_RRET_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_RRET_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_RRET_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRiskRegisterEventTypes] PRIMARY KEY CLUSTERED ([RiskEventTypeID] ASC)
);
