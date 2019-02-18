CREATE TABLE [Investment].[RegulatoryRuleValues] (
    [RegulatoryRuleValueId]     INT             IDENTITY (1, 1) NOT NULL,
    [RegulatoryRuleLimitId]     INT             NOT NULL,
    [ReportDate]                DATETIME        NOT NULL,
    [Value]                     DECIMAL (19, 5) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF_RRV_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF_RRV_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF_RRV_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF_RRV_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF_RRV_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRegulatoryRuleValues] PRIMARY KEY CLUSTERED ([RegulatoryRuleValueId] ASC),
    CONSTRAINT [RegulatoryRuleValuesRegulatoryRuleLimitId] FOREIGN KEY ([RegulatoryRuleLimitId]) REFERENCES [Investment].[RegulatoryRuleLimits] ([RegulatoryRuleLimitId])
);

