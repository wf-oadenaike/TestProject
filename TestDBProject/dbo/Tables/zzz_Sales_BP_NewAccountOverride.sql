CREATE TABLE [dbo].[zzz_Sales_BP_NewAccountOverride] (
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
    [SalesFromDate]               DATETIME        NULL,
    [SalesToDate]                 DATETIME        NULL,
    [MakeContact]                 BIT             NULL,
    [OverrideStatus]              VARCHAR (10)    NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)   NULL
);

