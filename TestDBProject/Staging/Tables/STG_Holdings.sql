CREATE TABLE [Staging].[STG_Holdings] (
    [Fund]             NVARCHAR (256) NULL,
    [Sector]           NVARCHAR (256) NULL,
    [SubSector]        NVARCHAR (256) NULL,
    [Ticker]           NVARCHAR (256) NULL,
    [NoPort]           NVARCHAR (256) NULL,
    [NoBench]          NVARCHAR (256) NULL,
    [WeightPort]       NVARCHAR (256) NULL,
    [WeightBench]      NVARCHAR (256) NULL,
    [Weight]           NVARCHAR (256) NULL,
    [MarketValuePort]  NVARCHAR (256) NULL,
    [PositionPort]     NVARCHAR (256) NULL,
    [ClosingPricePort] NVARCHAR (256) NULL,
    [CurrencyPort]     NVARCHAR (256) NULL,
    [FileName]         NVARCHAR (256) NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_SBH_CD] DEFAULT (getdate()) NOT NULL
);

