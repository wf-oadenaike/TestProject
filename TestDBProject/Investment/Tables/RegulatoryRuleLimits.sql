CREATE TABLE [Investment].[RegulatoryRuleLimits] (
    [RegulatoryRuleLimitId]     INT              IDENTITY (1, 1) NOT NULL,
    [FundCode]                  VARCHAR (20)     NOT NULL,
    [RuleId]                    VARCHAR (50)     NOT NULL,
    [RuleName]                  VARCHAR (100)    NOT NULL,
    [RuleShortDescr]            VARCHAR (50)     NULL,
    [RuleLimit1]                VARCHAR (50)     NULL,
    [LimitOperator]             VARCHAR (10)     NULL,
    [IsPercentage]              BIT              CONSTRAINT [DF_RRL_RLIP] DEFAULT ((1)) NOT NULL,
    [SubmittedByPersonId]       SMALLINT         CONSTRAINT [DF_RRL_RLSP] DEFAULT ((-1)) NOT NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_RRL_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_RRL_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_RRL_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_RRL_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_RRL_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRegulatoryRuleLimits] PRIMARY KEY CLUSTERED ([RegulatoryRuleLimitId] ASC),
    CONSTRAINT [RegulatoryRuleLimitsFundCode] FOREIGN KEY ([FundCode]) REFERENCES [dbo].[T_MASTER_FND] ([SHORT_NAME]),
    CONSTRAINT [RegulatoryRuleLimitsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIRegulatoryRuleLimits]
    ON [Investment].[RegulatoryRuleLimits]([FundCode] ASC, [RuleId] ASC);

