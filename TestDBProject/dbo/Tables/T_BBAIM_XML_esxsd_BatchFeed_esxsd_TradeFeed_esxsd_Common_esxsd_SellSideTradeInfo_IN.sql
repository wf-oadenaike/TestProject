CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_SellSideTradeInfo_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__1177DDF8] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [esxsd:TradeDate]        NVARCHAR (MAX) NULL,
    [esxsd:TradeAmount]      NVARCHAR (MAX) NULL,
    [esxsd:Commission]       NVARCHAR (MAX) NULL,
    [esxsd:Tax]              NVARCHAR (MAX) NULL,
    [esxsd:OtherFees]        NVARCHAR (MAX) NULL,
    [esxsd:NetMoney]         NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__126C0231] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__1360266A] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__14544AA3] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__15486EDC] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_SellSideTradeInfo_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

