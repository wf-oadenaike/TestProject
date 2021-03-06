﻿CREATE TABLE [dbo].[T_REF_PKG_STATUS] (
    [NO]                     INT           NOT NULL,
    [VALUE]                  VARCHAR (6)   NULL,
    [STATUS]                 VARCHAR (10)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([NO] ASC) WITH (FILLFACTOR = 80)
);

