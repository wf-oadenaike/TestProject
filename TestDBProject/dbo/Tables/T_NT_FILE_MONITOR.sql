﻿CREATE TABLE [dbo].[T_NT_FILE_MONITOR] (
    [TOPLEVELRUNID]          INT           NOT NULL,
    [EVENT_DATETIME]         DATETIME      NULL,
    [FILENAME]               VARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_NT_FILE__CADIS__3CC16359] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_NT_FILE__CADIS__3DB58792] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_NT_FILE__CADIS__3EA9ABCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_NT_FILE__CADIS__3F9DD004] DEFAULT ((1)) NULL,
    CONSTRAINT [PK__T_NT_FIL__F4AF7C73243C2E34] PRIMARY KEY CLUSTERED ([TOPLEVELRUNID] ASC) WITH (FILLFACTOR = 90)
);

