﻿CREATE TABLE [dbo].[T_OMNIS_GROSS_FUND_FLOW] (
    [ROW_NUMBER]                INT             NOT NULL,
    [TYPE]                      VARCHAR (20)    NOT NULL,
    [FUND]                      VARCHAR (50)    NULL,
    [TRANSACTION_DATE]          DATETIME        NULL,
    [FUND_FLOW_TYPE]            VARCHAR (20)    NULL,
    [FLOW_TYPE]                 VARCHAR (100)   NULL,
    [MARKET_VALUE]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF__T_OMNIS_G__CADIS__58D8562C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF__T_OMNIS_G__CADIS__59CC7A65] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF__T_OMNIS_G__CADIS__5AC09E9E] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF__T_OMNIS_G__CADIS__5BB4C2D7] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF__T_OMNIS_G__CADIS__5CA8E710] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_OMNIS___EED21959ADF4CB75] PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC) WITH (FILLFACTOR = 90)
);

