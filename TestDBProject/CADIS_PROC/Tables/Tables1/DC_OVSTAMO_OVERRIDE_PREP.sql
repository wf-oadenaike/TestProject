CREATE TABLE [CADIS_PROC].[DC_OVSTAMO_OVERRIDE_PREP] (
    [SfAccountId]           VARCHAR (18)     NOT NULL,
    [Sector]                VARCHAR (10)     NOT NULL,
    [AccountName]           NVARCHAR (1000)  NULL,
    [AccountOwnerId]        VARCHAR (18)     NULL,
    [IsPriorityClient]      BIT              NULL,
    [CurrOutletOwnSales]    DECIMAL (18, 2)  NULL,
    [PrevOutletOwnSales]    DECIMAL (18, 2)  NULL,
    [SalesMoveValue]        DECIMAL (19, 2)  NULL,
    [CurrOutletMarketSales] DECIMAL (18, 2)  NULL,
    [PrevOutletMarketSales] DECIMAL (18, 2)  NULL,
    [CurrMktShare]          DECIMAL (38, 16) NULL,
    [PrevMktShare]          DECIMAL (38, 16) NULL,
    [MktShareMoveValue]     DECIMAL (38, 16) NOT NULL,
    [MakeContact]           BIT              NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [Sector] ASC) WITH (FILLFACTOR = 80)
);

