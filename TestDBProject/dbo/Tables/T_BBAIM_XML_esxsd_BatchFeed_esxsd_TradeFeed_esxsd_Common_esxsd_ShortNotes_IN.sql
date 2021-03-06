﻿CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_ShortNotes_IN] (
    [CADIS_BATCH_ID]         INT           NOT NULL,
    [CADIS_MSG_ID]           INT           CONSTRAINT [DF__T_BBAIM_X__CADIS__62BCEF0F] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT           NOT NULL,
    [CADIS_ROW_ID]           INT           NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BBAIM_X__CADIS__63B11348] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BBAIM_X__CADIS__64A53781] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BBAIM_X__CADIS__65995BBA] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BBAIM_X__CADIS__668D7FF3] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_ShortNotes_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

