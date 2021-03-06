﻿CREATE TABLE [dbo].[T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_TaxLots_esxsd_Lot_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__2C2BD434] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [esxsd:ID]               NVARCHAR (MAX) NULL,
    [esxsd:Price]            NVARCHAR (MAX) NULL,
    [esxsd:Amt]              NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__2D1FF86D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_BBAIM_X__CADIS__2E141CA6] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_BBAIM_X__CADIS__2F0840DF] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_BBAIM_X__CADIS__2FFC6518] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_BBAIM_XML_esxsd_BatchFeed_esxsd_TradeFeed_esxsd_Common_esxsd_TaxLots_esxsd_Lot_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

