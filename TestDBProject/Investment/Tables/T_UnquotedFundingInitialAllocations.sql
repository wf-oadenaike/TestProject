CREATE TABLE [Investment].[T_UnquotedFundingInitialAllocations] (
    [ID]               INT             IDENTITY (1, 1) NOT NULL,
    [FundingID]        INT             NULL,
    [PortfolioID]      INT             NULL,
    [AllocationAmount] DECIMAL (18, 2) NULL,
    CONSTRAINT [PK_UnquotedFundingInitialAllocationsID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

