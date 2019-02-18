﻿CREATE TABLE [dbo].[T_BPS_CORE_IN] (
    [FILE_NAME]              VARCHAR (50)  NULL,
    [DATE]                   DATETIME      NULL,
    [IDENTIFIER]             VARCHAR (50)  NULL,
    [FIELD]                  VARCHAR (50)  NULL,
    [VALUE]                  VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BPS_COR__CADIS__25460592] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BPS_COR__CADIS__263A29CB] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BPS_COR__CADIS__272E4E04] DEFAULT ('UNKNOWN') NULL
);

