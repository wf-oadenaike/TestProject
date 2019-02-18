CREATE TABLE [Staging].[STG_Cash] (
    [TradeDate]            VARCHAR (8)  NULL,
    [AccountName]          VARCHAR (8)  NULL,
    [CashUpdateType]       VARCHAR (3)  NULL,
    [CashAdjustmentAmount] VARCHAR (21) NULL,
    [TradeDateCash]        VARCHAR (21) NULL,
    [SettlementDateCash]   VARCHAR (21) NULL,
    [CurrencyCode]         VARCHAR (5)  NULL,
    [CashTicketCode]       VARCHAR (6)  NULL,
    [Asofdate]             VARCHAR (8)  NULL,
    [Security]             VARCHAR (40) NULL,
    [Notes]                VARCHAR (40) NULL,
    [PrimeBroker]          VARCHAR (7)  NULL,
    [Strategy]             VARCHAR (40) NULL,
    [ClassID]              VARCHAR (15) NULL,
    [NumberofUnits]        VARCHAR (21) NULL,
    [UnitValue]            VARCHAR (21) NULL
);

