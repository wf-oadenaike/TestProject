﻿CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_LongNotes_esxsd_LongNote_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__76C3E7BC] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [esxsd:Index]            NVARCHAR (MAX) NULL,
    [esxsd:Text]             NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__77B80BF5] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__78AC302E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__79A05467] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__7A9478A0] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_LongNotes_esxsd_LongNote_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);
