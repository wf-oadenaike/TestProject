﻿CREATE TABLE [dbo].[T_BPS_REQUEST_MANUAL] (
    [ID_BB_UNIQUE]           VARCHAR (30)  NOT NULL,
    [NOTES]                  VARCHAR (100) NULL,
    [EDM_SEC_ID]             VARCHAR (30)  NULL,
    [ID_BB_GLOBAL]           VARCHAR (30)  NULL,
    [SEDOL]                  VARCHAR (7)   NULL,
    [ISIN]                   VARCHAR (12)  NULL,
    [CUSIP]                  VARCHAR (9)   NULL,
    [TICKER]                 VARCHAR (26)  NULL,
    [BPS_YELLOWKEY]          VARCHAR (30)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([ID_BB_UNIQUE] ASC) WITH (FILLFACTOR = 90)
);

