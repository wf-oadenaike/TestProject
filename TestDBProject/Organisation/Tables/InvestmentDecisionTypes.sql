CREATE TABLE [Organisation].[InvestmentDecisionTypes] (
    [InvestmentDecisionType]        CHAR (3)  NOT NULL,
    [InvestmentDecision]            [sysname] NOT NULL,
    [InvestmentDecisionDescription] [sysname] NOT NULL,
    CONSTRAINT [XPKInvestmentDecision] PRIMARY KEY CLUSTERED ([InvestmentDecisionType] ASC)
);

