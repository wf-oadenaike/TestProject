CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_TransactionCosts_esxsd_TransactionCost_IN] (
    [CADIS_BATCH_ID]           INT            NOT NULL,
    [CADIS_MSG_ID]             INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__46DFCA70] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]          INT            NOT NULL,
    [CADIS_ROW_ID]             INT            NOT NULL,
    [esxsd:Type]               NVARCHAR (MAX) NULL,
    [esxsd:Currency]           NVARCHAR (MAX) NULL,
    [esxsd:Code]               NVARCHAR (MAX) NULL,
    [esxsd:Cost]               NVARCHAR (MAX) NULL,
    [esxsd:EffectOnFinalMoney] NVARCHAR (MAX) NULL,
    [esxsd:Rate]               NVARCHAR (MAX) NULL,
    [esxsd:AdjustedRateEffect] NVARCHAR (MAX) NULL,
    [esxsd:Override]           NVARCHAR (MAX) NULL,
    [esxsd:CurrencyRate]       NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__47D3EEA9] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__48C812E2] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__49BC371B] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]    INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__4AB05B54] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_TransactionCosts_esxsd_TransactionCost_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

