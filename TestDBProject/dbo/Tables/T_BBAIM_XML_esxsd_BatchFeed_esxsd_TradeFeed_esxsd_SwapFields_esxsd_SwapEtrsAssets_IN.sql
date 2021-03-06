﻿CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_SwapFields_esxsd_SwapEtrsAssets_IN] (
    [CADIS_BATCH_ID]         INT           NOT NULL,
    [CADIS_MSG_ID]           INT           CONSTRAINT [DF__T_BBAIM_X__CADIS__45B69C0D] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT           NOT NULL,
    [CADIS_ROW_ID]           INT           NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BBAIM_X__CADIS__46AAC046] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BBAIM_X__CADIS__479EE47F] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BBAIM_X__CADIS__489308B8] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BBAIM_X__CADIS__49872CF1] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_SwapFields_esxsd_SwapEtrsAssets_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

