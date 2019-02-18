﻿CREATE TABLE [dbo].[T_BPS_FILE_MONITOR] (
    [TOPLEVELRUNID]          INT           NOT NULL,
    [EVENT_DATETIME]         DATETIME      NULL,
    [FILENAME]               VARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BPS_FIL__CADIS__1C3BBE45] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BPS_FIL__CADIS__1D2FE27E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BPS_FIL__CADIS__1E2406B7] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BPS_FIL__CADIS__1F182AF0] DEFAULT ((1)) NULL,
    CONSTRAINT [PK__T_BPS_FI__F4AF7C732D630930] PRIMARY KEY CLUSTERED ([TOPLEVELRUNID] ASC) WITH (FILLFACTOR = 90)
);

