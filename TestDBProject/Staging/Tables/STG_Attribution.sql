CREATE TABLE [Staging].[STG_Attribution] (
    [Fund]                      NVARCHAR (256) NULL,
    [Sector]                    NVARCHAR (256) NULL,
    [SubSector]                 NVARCHAR (256) NULL,
    [Ticker]                    NVARCHAR (256) NULL,
    [AverageWeightPort]         NVARCHAR (256) NULL,
    [AverageWeightBench]        NVARCHAR (256) NULL,
    [AverageWeight]             NVARCHAR (256) NULL,
    [ContributiontoReturnPort]  NVARCHAR (256) NULL,
    [ContributiontoReturnBench] NVARCHAR (256) NULL,
    [ContributiontoReturn]      NVARCHAR (256) NULL,
    [TotalReturnPort]           NVARCHAR (256) NULL,
    [TotalReturnBench]          NVARCHAR (256) NULL,
    [TotalReturn]               NVARCHAR (256) NULL,
    [TotalAttribution]          NVARCHAR (256) NULL,
    [AllocationEffect]          NVARCHAR (256) NULL,
    [SelectionEffect]           NVARCHAR (256) NULL,
    [CurrencyEffect]            NVARCHAR (256) NULL,
    [FileName]                  NVARCHAR (256) NULL,
    [CreatedDate]               DATETIME       CONSTRAINT [DF_SBA_CD] DEFAULT (getdate()) NOT NULL
);

