﻿CREATE TABLE [dbo].[T_BPS_REQUEST_ALL_OUT] (
    [SOURCE]                    VARCHAR (50)  NOT NULL,
    [SOURCE_ID]                 VARCHAR (50)  NOT NULL,
    [REQUEST_ID_TYPE]           VARCHAR (50)  NULL,
    [REQUEST_ID]                VARCHAR (50)  NULL,
    [REQUEST_REGION]            VARCHAR (50)  NULL,
    [BB_EXCHANGE]               VARCHAR (2)   NULL,
    [PRICING_SOURCE]            VARCHAR (30)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF__T_BPS_REQ__CADIS__5C5ECE4D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF__T_BPS_REQ__CADIS__5D52F286] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF__T_BPS_REQ__CADIS__5E4716BF] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF__T_BPS_REQ__CADIS__5F3B3AF8] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF__T_BPS_REQ__CADIS__602F5F31] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_BPS_RE__4DD5E48167DC707D] PRIMARY KEY CLUSTERED ([SOURCE] ASC, [SOURCE_ID] ASC) WITH (FILLFACTOR = 90)
);

