CREATE TABLE [CADIS_PROC].[DC_OSTNAO_OVERRIDE_PREP] (
    [MatrixOutletId]              VARCHAR (50)    NOT NULL,
    [AccountName]                 VARCHAR (2000)  NULL,
    [AccountFcaId]                VARCHAR (100)   NULL,
    [AccountOwnerId]              VARCHAR (18)    NULL,
    [BillingCity]                 VARCHAR (200)   NULL,
    [BillingPostCode]             VARCHAR (200)   NULL,
    [TotalOwnSales]               DECIMAL (20, 2) NULL,
    [TotalMarketSales]            DECIMAL (20, 2) NULL,
    [EquityIncomeOwnSales]        DECIMAL (20, 2) NULL,
    [EquityIncomeMarketSales]     DECIMAL (20, 2) NULL,
    [SpecialistSectorOwnSales]    DECIMAL (20, 2) NULL,
    [SpecialistSectorMarketSales] DECIMAL (20, 2) NULL,
    [MakeContact]                 BIT             NULL,
    [OverrideStatus]              VARCHAR (10)    NULL,
    PRIMARY KEY CLUSTERED ([MatrixOutletId] ASC) WITH (FILLFACTOR = 80)
);

