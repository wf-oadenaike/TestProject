CREATE TABLE [CADIS_PROC].[DI_INPUT220_PROCESSKEYS] (
    [PortfolioGroup] VARCHAR (250) NOT NULL,
    [ReportDate]     DATETIME      NOT NULL,
    [Security]       VARCHAR (250) NOT NULL,
    PRIMARY KEY CLUSTERED ([PortfolioGroup] ASC, [ReportDate] ASC, [Security] ASC) WITH (FILLFACTOR = 80)
);

