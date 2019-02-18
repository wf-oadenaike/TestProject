CREATE TABLE [Investment].[T_UnquotedFundingPortfolioAllocations] (
    [ID]                     INT             IDENTITY (1, 1) NOT NULL,
    [SecurityAllocationID]   INT             NULL,
    [PortfolioID]            INT             NULL,
    [AllocationAmount]       DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_UnquotedFundingPortfolioAllocationID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

