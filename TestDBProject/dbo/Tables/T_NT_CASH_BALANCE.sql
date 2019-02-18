CREATE TABLE [dbo].[T_NT_CASH_BALANCE] (
    [FILE_NAME]              VARCHAR (250)   NULL,
    [FILE_TYPE]              VARCHAR (250)   NULL,
    [FILE_DATE]              VARCHAR (250)   NULL,
    [TradeDate]              VARCHAR (8)     NULL,
    [AccountName]            VARCHAR (8)     NULL,
    [CashUpdateType]         VARCHAR (3)     NULL,
    [CashAdjustmentAmount]   DECIMAL (38, 2) NULL,
    [TradeDateCash]          DECIMAL (38, 2) NULL,
    [SettlementDateCash]     DECIMAL (38, 2) NULL,
    [CurrencyCode]           VARCHAR (5)     NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (250)  NULL
);

