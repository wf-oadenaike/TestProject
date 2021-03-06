﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFNDMKT_INFO_VALUE] (
    [SOURCE]                          VARCHAR (50)    NOT NULL,
    [POSITION_TYPE]                   VARCHAR (50)    NOT NULL,
    [FUND_SHORT_NAME]                 VARCHAR (8000)  NOT NULL,
    [POSITION_DATE]                   DATETIME        NOT NULL,
    [TOTAL_MARKET_VALUE_LOCAL]        DECIMAL (20, 2) NULL,
    [TOTAL_MARKET_VALUE_BASE]         DECIMAL (20, 2) NULL,
    [STATUS]                          VARCHAR (20)    NULL,
    [TOTAL_ACCRUED_MARKET_VALUE_BASE] DECIMAL (20, 2) NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED]       DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC)
);

