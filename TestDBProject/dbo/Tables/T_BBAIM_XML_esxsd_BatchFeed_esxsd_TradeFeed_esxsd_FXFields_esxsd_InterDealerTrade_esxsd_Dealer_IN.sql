CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_FXFields_esxsd_InterDealerTrade_esxsd_Dealer_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__759AB959] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [esxsd:CCY1Amt]          NVARCHAR (MAX) NULL,
    [esxsd:CCY2Amt]          NVARCHAR (MAX) NULL,
    [esxsd:BuySellFlag]      NVARCHAR (MAX) NULL,
    [esxsd:SpotRate]         NVARCHAR (MAX) NULL,
    [esxsd:Points]           NVARCHAR (MAX) NULL,
    [esxsd:Rate]             NVARCHAR (MAX) NULL,
    [esxsd:Book]             NVARCHAR (MAX) NULL,
    [esxsd:Ticket]           NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__768EDD92] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__778301CB] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__78772604] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__796B4A3D] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_FXFields_esxsd_InterDealerTrade_esxsd_Dealer_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

