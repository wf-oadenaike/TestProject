﻿CREATE TABLE [dbo].[T_OVERRIDE_FND_MARKET_VALUE_RESET] (
    [SOURCE]                          VARCHAR (50)   NOT NULL,
    [POSITION_TYPE]                   VARCHAR (50)   NOT NULL,
    [FUND_SHORT_NAME]                 VARCHAR (8000) NOT NULL,
    [POSITION_DATE]                   DATETIME       NOT NULL,
    [TOTAL_MARKET_VALUE_LOCAL]        BIT            NULL,
    [TOTAL_MARKET_VALUE_BASE]         BIT            NULL,
    [STATUS]                          BIT            NULL,
    [TOTAL_ACCRUED_MARKET_VALUE_BASE] BIT            NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME       CONSTRAINT [DF__T_OVERRID__CADIS__076ABE91] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME       CONSTRAINT [DF__T_OVERRID__CADIS__085EE2CA] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)  CONSTRAINT [DF__T_OVERRID__CADIS__09530703] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT            CONSTRAINT [DF__T_OVERRID__CADIS__0A472B3C] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED]       DATETIME       CONSTRAINT [DF__T_OVERRID__CADIS__0B3B4F75] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]          ROWVERSION     NOT NULL,
    CONSTRAINT [PK__T_OVERRI__D5F86804384768B8] PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC) WITH (FILLFACTOR = 90)
);
