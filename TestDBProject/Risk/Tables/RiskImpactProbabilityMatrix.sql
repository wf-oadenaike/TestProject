CREATE TABLE [Risk].[RiskImpactProbabilityMatrix] (
    [RiskImpactId]              SMALLINT      NOT NULL,
    [RiskProbabilityId]         SMALLINT      NOT NULL,
    [RiskExposure]              VARCHAR (25)  NOT NULL,
    [RiskScore]                 INT           NOT NULL,
    [CreatedDate]               DATETIME      CONSTRAINT [DEF_RIPM_CDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_RIPM_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_RIPM_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_RIPM_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_RIPM_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_RIPM_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRiskImpactProbabilityMatrix] PRIMARY KEY CLUSTERED ([RiskImpactId] ASC, [RiskProbabilityId] ASC),
    CONSTRAINT [RiskImpactProbabilityMatrixRiskImpactId] FOREIGN KEY ([RiskImpactId]) REFERENCES [Risk].[RiskImpact] ([RiskImpactId]),
    CONSTRAINT [RiskImpactProbabilityMatrixRiskProbabilityId] FOREIGN KEY ([RiskProbabilityId]) REFERENCES [Risk].[RiskProbability] ([RiskProbabilityId])
);

