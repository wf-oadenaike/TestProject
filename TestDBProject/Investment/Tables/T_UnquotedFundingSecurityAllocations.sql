CREATE TABLE [Investment].[T_UnquotedFundingSecurityAllocations] (
    [ID]                     INT             IDENTITY (1, 1) NOT NULL,
    [FundingID]              INT             NULL,
    [SecurityID]             INT             NULL,
    [AllocationAmount]       DECIMAL (18, 2) NULL,
    [RevaluationID]          INT             NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_UnquotedFundingSecurityAllocationID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

