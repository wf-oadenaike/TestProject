CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_SwapFields_esxsd_BasketReferenceBondIds_esxsd_ReferenceBondID_IN] (
    [CADIS_BATCH_ID]                  INT            NOT NULL,
    [CADIS_MSG_ID]                    INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__3F099E7E] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                 INT            NOT NULL,
    [CADIS_ROW_ID]                    INT            NOT NULL,
    [esxsd:ReferenceBondID_InnerText] NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__3FFDC2B7] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__40F1E6F0] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__41E60B29] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__42DA2F62] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_SwapFields_esxsd_BasketReferenceBondIds_esxsd_ReferenceBondID_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

