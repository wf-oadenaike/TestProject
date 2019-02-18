CREATE TABLE [Trading].[CashPositions] (
    [CashPositionId]               INT             IDENTITY (1, 1) NOT NULL,
    [TradeDate]                    DATE            NOT NULL,
    [AccountName]                  VARCHAR (25)    NOT NULL,
    [CashUpdateType]               INT             NOT NULL,
    [CashAdjustmentAmount]         DECIMAL (19, 5) NULL,
    [TradeDateCash]                DECIMAL (19, 5) NULL,
    [SettlementDateCash]           DECIMAL (19, 5) NULL,
    [CurrencyCode]                 CHAR (3)        NOT NULL,
    [CashTicketCode]               VARCHAR (25)    NULL,
    [Asofdate]                     DATE            NULL,
    [Security]                     VARCHAR (25)    NULL,
    [Notes]                        VARCHAR (128)   NULL,
    [PrimeBroker]                  VARCHAR (25)    NULL,
    [Strategy]                     VARCHAR (25)    NULL,
    [ClassID]                      INT             NULL,
    [NumberofUnits]                DECIMAL (19, 5) NULL,
    [UnitValue]                    DECIMAL (19, 5) NULL,
    [CashPositionCreatedDatetime]  DATETIME        CONSTRAINT [DF_CP_CPCDT] DEFAULT (getdate()) NOT NULL,
    [CashPositionModifiedDatetime] DATETIME        CONSTRAINT [DF_CP_CPMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKCashPositions] PRIMARY KEY CLUSTERED ([CashPositionId] ASC)
);

