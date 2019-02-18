CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_FXFields_esxsd_NDF_IN] (
    [CADIS_BATCH_ID]              INT            NOT NULL,
    [CADIS_MSG_ID]                INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__6193C0AC] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]             INT            NOT NULL,
    [CADIS_ROW_ID]                INT            NOT NULL,
    [esxsd:MarketType]            NVARCHAR (MAX) NULL,
    [esxsd:SettlementCurrency]    NVARCHAR (MAX) NULL,
    [esxsd:FixingDateTime]        NVARCHAR (MAX) NULL,
    [esxsd:GMTOffsetSign]         NVARCHAR (MAX) NULL,
    [esxsd:GMTOffset]             NVARCHAR (MAX) NULL,
    [esxsd:FixingRate]            NVARCHAR (MAX) NULL,
    [esxsd:ReferenceTicketNumber] NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__6287E4E5] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__637C091E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__64702D57] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]       INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__65645190] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_FXFields_esxsd_NDF_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

