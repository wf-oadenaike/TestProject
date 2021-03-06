﻿CREATE TABLE [dbo].[T_REF_STOCK_TICKER] (
    [INDEX_ID]               INT           IDENTITY (1, 1) NOT NULL,
    [SECURITY_NAME]          VARCHAR (255) NOT NULL,
    [TICKER]                 VARCHAR (50)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([INDEX_ID] ASC) WITH (FILLFACTOR = 80)
);

