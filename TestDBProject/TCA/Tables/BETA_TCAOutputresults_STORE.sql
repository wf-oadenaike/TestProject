CREATE TABLE [TCA].[BETA_TCAOutputresults_STORE] (
    [PARENT_RUN_ID]          BIGINT        NOT NULL,
    [STORE_DATE]             DATE          NOT NULL,
    [ID]                     BIGINT        IDENTITY (1, 1) NOT NULL,
    [DecisionDateTime]       VARCHAR (255) NULL,
    [ParentOrderID]          VARCHAR (255) NULL,
    [OrderID]                VARCHAR (255) NULL,
    [BrokerRouteTime]        VARCHAR (255) NULL,
    [FirstFill]              VARCHAR (255) NULL,
    [TotalOrderSize]         VARCHAR (255) NULL,
    [BrokerReleaseSize]      VARCHAR (255) NULL,
    [OrderSize]              VARCHAR (255) NULL,
    [ReleaseID]              VARCHAR (255) NULL,
    [ReleaseDateTime]        VARCHAR (255) NULL,
    [TraderBlockID]          VARCHAR (255) NULL,
    [TraderDateTime]         VARCHAR (255) NULL,
    [TraderSize]             VARCHAR (255) NULL,
    [BrokerID]               VARCHAR (255) NULL,
    [BrokerDateTime]         VARCHAR (255) NULL,
    [Symbol]                 VARCHAR (255) NULL,
    [SymbolType]             VARCHAR (255) NULL,
    [Side]                   VARCHAR (255) NULL,
    [Shares]                 VARCHAR (255) NULL,
    [AllocationDateTime]     VARCHAR (255) NULL,
    [Price]                  VARCHAR (255) NULL,
    [Account]                VARCHAR (255) NULL,
    [Trader]                 VARCHAR (255) NULL,
    [Exchange]               VARCHAR (255) NULL,
    [Country]                VARCHAR (255) NULL,
    [Currency]               VARCHAR (255) NULL,
    [UDMFUND]                VARCHAR (255) NULL,
    [UDMSTRATEGY]            VARCHAR (255) NULL,
    [UDMPMINSTRUCTIONS]      VARCHAR (255) NULL,
    [UDMPMORDERREASON]       VARCHAR (255) NULL,
    [UDMTRADEDESK]           VARCHAR (255) NULL,
    [UDMPROGRAMID]           VARCHAR (255) NULL,
    [TRADEID]                VARCHAR (255) NULL,
    [SalesCommission]        VARCHAR (255) NULL,
    [BrokerCommission]       VARCHAR (255) NULL,
    [ExchangeFee]            VARCHAR (255) NULL,
    [WithholdingTax]         VARCHAR (255) NULL,
    [TransferTax]            VARCHAR (255) NULL,
    [StampDuty]              VARCHAR (255) NULL,
    [MiscellaneousFee]       VARCHAR (255) NULL,
    [Dividend]               VARCHAR (255) NULL,
    [DividendCCY]            VARCHAR (255) NULL,
    [SpecialDividend]        VARCHAR (255) NULL,
    [SpecialDividendCCY]     VARCHAR (255) NULL,
    [Note1]                  VARCHAR (255) NULL,
    [Note2]                  VARCHAR (255) NULL,
    [Note3]                  VARCHAR (255) NULL,
    [C_EVENT]                VARCHAR (255) NULL,
    [AggregatedTo]           VARCHAR (255) NULL,
    [AggregatedFrom]         VARCHAR (255) NULL,
    [C_SECURITY]             VARCHAR (255) NULL,
    [REASONCODE]             VARCHAR (255) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [SHARES_BY_ACCOUNT]      VARCHAR (255) NULL,
    PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE CLUSTERED INDEX [CIX_BETA_TCAOutputresults_STORE]
    ON [TCA].[BETA_TCAOutputresults_STORE]([PARENT_RUN_ID] ASC, [STORE_DATE] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_BETA_TCAOutputresults_STORE_REC]
    ON [TCA].[BETA_TCAOutputresults_STORE]([DecisionDateTime] ASC, [ParentOrderID] ASC, [OrderID] ASC)
    INCLUDE([Symbol], [Account], [BrokerID], [C_SECURITY], [Side], [TotalOrderSize], [Shares], [Price], [BrokerCommission], [Dividend], [SpecialDividend], [REASONCODE]) WITH (FILLFACTOR = 80);

