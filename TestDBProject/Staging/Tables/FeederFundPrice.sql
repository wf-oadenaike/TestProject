CREATE TABLE [Staging].[FeederFundPrice] (
    [ValuationDate]   NVARCHAR (511) NULL,
    [PriorDate]       NVARCHAR (511) NULL,
    [Account]         NVARCHAR (511) NULL,
    [Class]           NVARCHAR (511) NULL,
    [Series]          NVARCHAR (511) NULL,
    [Name]            NVARCHAR (511) NULL,
    [SEDOL]           NVARCHAR (511) NULL,
    [Currency]        NVARCHAR (511) NULL,
    [Units]           NVARCHAR (511) NULL,
    [NetAssets]       NVARCHAR (511) NULL,
    [PriorNetAssets]  NVARCHAR (511) NULL,
    [NAVperUnit]      NVARCHAR (511) NULL,
    [PriorNAVperUnit] NVARCHAR (511) NULL,
    [NAVChange]       NVARCHAR (511) NULL,
    [BidSpread]       NVARCHAR (511) NULL,
    [BidPrice]        NVARCHAR (511) NULL,
    [OfferSpread]     NVARCHAR (511) NULL,
    [OfferPrice]      NVARCHAR (511) NULL,
    [IndexChange]     NVARCHAR (511) NULL,
    [Filename]        NVARCHAR (511) NULL,
    [CreatedDate]     DATETIME       CONSTRAINT [df_ffp_cd] DEFAULT (getdate()) NOT NULL
);

