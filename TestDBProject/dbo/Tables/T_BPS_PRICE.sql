﻿CREATE TABLE [dbo].[T_BPS_PRICE] (
    [FILE_NAME]              VARCHAR (50)  NULL,
    [DATE]                   DATETIME      NULL,
    [IDENTIFIER]             VARCHAR (50)  NULL,
    [FIELD]                  VARCHAR (50)  NULL,
    [VALUE]                  VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BPS_PRI__CADIS__14BA980E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BPS_PRI__CADIS__15AEBC47] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BPS_PRI__CADIS__16A2E080] DEFAULT ('UNKNOWN') NULL
);
