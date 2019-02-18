CREATE TABLE [Investment].[Portfolios] (
    [PortfolioCode]         VARCHAR (25)  NOT NULL,
    [PortfolioName]         VARCHAR (128) NOT NULL,
    [PortfolioDescription]  VARCHAR (128) NOT NULL,
    [PortfolioCreationDate] DATETIME      CONSTRAINT [DF_PO_PCDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKPortfolioCode] PRIMARY KEY CLUSTERED ([PortfolioCode] ASC)
);

