﻿CREATE TABLE [dbo].[T_BPS_PH_FILENAME] (
    [FILENAME]               VARCHAR (50)  NULL,
    [SIZE]                   VARCHAR (50)  NULL,
    [LAST_MODIFIED]          VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BPS_PH___CADIS__69462A24] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BPS_PH___CADIS__6A3A4E5D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BPS_PH___CADIS__6B2E7296] DEFAULT ('UNKNOWN') NULL
);

