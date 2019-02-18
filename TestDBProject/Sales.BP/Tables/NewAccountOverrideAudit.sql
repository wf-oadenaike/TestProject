﻿CREATE TABLE [Sales.BP].[NewAccountOverrideAudit] (
    [NewAccountOverrideAuditId]   INT             IDENTITY (1, 1) NOT NULL,
    [AuditDate]                   DATETIME        NULL,
    [AuditUser]                   VARCHAR (50)    NULL,
    [MatrixOutletId]              VARCHAR (50)    NULL,
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
    [CADIS_SYSTEM_INSERTED]       DATETIME        CONSTRAINT [DF_SBNAOA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME        CONSTRAINT [DF_SBNAOA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)   CONSTRAINT [DF_SBNAOA_CSCB] DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([NewAccountOverrideAuditId] ASC) WITH (FILLFACTOR = 80)
);
