CREATE TABLE [Investment].[RegulatoryRuleDetail] (
    [FundCode]         VARCHAR (20)    NOT NULL,
    [RuleId]           VARCHAR (50)    NOT NULL,
    [Ticker]           VARCHAR (50)    NOT NULL,
    [Identifier]       VARCHAR (100)   NOT NULL,
    [Quantity]         DECIMAL (19, 2) NOT NULL,
    [Price]            DECIMAL (19, 2) NOT NULL,
    [SecurityCurrency] VARCHAR (100)   NULL,
    [MarketValue]      DECIMAL (19, 2) DEFAULT ((0.00)) NOT NULL,
    [Attribute1]       VARCHAR (100)   NULL,
    [Attribute2]       VARCHAR (100)   NULL,
    [InViolation]      VARCHAR (1)     NOT NULL,
    [EFFECTIVE_DATE]   INT             NOT NULL,
    [REPORT_DATE]      INT             NOT NULL
);

