CREATE TABLE [Investment].[RegulatoryRuleSummary] (
    [FundCode]       VARCHAR (20)  NOT NULL,
    [RuleId]         VARCHAR (50)  NOT NULL,
    [RuleName]       VARCHAR (100) NOT NULL,
    [RuleCcy]        VARCHAR (5)   NOT NULL,
    [ScopeContext]   VARCHAR (100) NULL,
    [RiskLabel]      VARCHAR (100) NULL,
    [RuleLimit]      VARCHAR (100) NOT NULL,
    [Value]          VARCHAR (100) DEFAULT ('0') NOT NULL,
    [Room]           VARCHAR (100) DEFAULT ('0') NOT NULL,
    [InViolation]    VARCHAR (1)   NOT NULL,
    [EFFECTIVE_DATE] INT           NOT NULL,
    [REPORT_DATE]    INT           NOT NULL
);

