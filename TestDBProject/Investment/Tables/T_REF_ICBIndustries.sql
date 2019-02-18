CREATE TABLE [Investment].[T_REF_ICBIndustries] (
    [ID]                  SMALLINT      NOT NULL,
    [ICBID]               VARCHAR (4)   NOT NULL,
    [Name]                VARCHAR (100) NOT NULL,
    [FundManagerID]       SMALLINT      NULL,
    [InvestmentAnalystID] SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_CorePersons.FundManagerID] FOREIGN KEY ([FundManagerID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [FK_CorePersons.InvestmentAnalystID] FOREIGN KEY ([InvestmentAnalystID]) REFERENCES [Core].[Persons] ([PersonId])
);

