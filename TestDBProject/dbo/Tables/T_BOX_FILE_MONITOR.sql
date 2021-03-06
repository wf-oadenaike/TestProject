﻿CREATE TABLE [dbo].[T_BOX_FILE_MONITOR] (
    [TOPLEVELRUNID]          INT           NOT NULL,
    [EVENT_DATETIME]         DATETIME      NULL,
    [FILENAME]               VARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BOX_FILE__CADIS__3CC16359] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BOX_FILE__CADIS__3DB58792] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BOX_FILE__CADIS__3EA9ABCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BOX_FILE__CADIS__3F9DD004] DEFAULT ((1)) NULL,
    CONSTRAINT [PKT_BOX_FILE_MONITOR] PRIMARY KEY CLUSTERED ([TOPLEVELRUNID] ASC) WITH (FILLFACTOR = 90)
);

