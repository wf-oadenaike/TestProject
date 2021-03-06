﻿CREATE TABLE [dbo].[T_BPS_REQUEST_STATUS] (
    [BPS_ID]                       INT           IDENTITY (1, 1) NOT NULL,
    [SOURCE_1]                     VARCHAR (30)  NULL,
    [EDM_SEC_ID]                   VARCHAR (30)  NULL,
    [ID_BB_UNIQUE]                 VARCHAR (30)  NOT NULL,
    [ID_BB_GLOBAL]                 VARCHAR (30)  NULL,
    [SEDOL]                        VARCHAR (7)   NULL,
    [ISIN]                         VARCHAR (12)  NULL,
    [CUSIP]                        VARCHAR (9)   NULL,
    [TICKER]                       VARCHAR (26)  NULL,
    [BPS_YELLOWKEY]                VARCHAR (30)  NULL,
    [SECURITY_TYP]                 VARCHAR (50)  NULL,
    [ASSET_TYPE]                   VARCHAR (50)  NULL,
    [FIELD_GROUP]                  VARCHAR (20)  NULL,
    [STATUS_CORE_REQUEST]          VARCHAR (20)  NULL,
    [STATUS_SECURITY_REQUEST]      VARCHAR (20)  NULL,
    [STATUS_PRICE_HISTORY_REQUEST] VARCHAR (20)  NULL,
    [LAST_DAILY_PRICE_REQUESTED]   VARCHAR (100) NULL,
    [LAST_DAILY_PRICE_RECEIVED]    VARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]        DATETIME      CONSTRAINT [DF__T_BPS_REQ__CADIS__1EDFF36A] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]         DATETIME      CONSTRAINT [DF__T_BPS_REQ__CADIS__1FD417A3] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]       NVARCHAR (50) CONSTRAINT [DF__T_BPS_REQ__CADIS__20C83BDC] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]        INT           CONSTRAINT [DF__T_BPS_REQ__CADIS__21BC6015] DEFAULT ((1)) NULL,
    CONSTRAINT [PK__T_BPS_RE__DC3AD948AE1D5BE5] PRIMARY KEY CLUSTERED ([BPS_ID] ASC) WITH (FILLFACTOR = 90)
);

