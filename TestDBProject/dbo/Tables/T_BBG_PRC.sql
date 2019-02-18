﻿CREATE TABLE [dbo].[T_BBG_PRC] (
    [FILE_NAME]                 VARCHAR (100)   NULL,
    [FILE_TYPE]                 VARCHAR (20)    NULL,
    [FILE_DATE]                 DATETIME        NULL,
    [PRICE_FILE_TYPE]           VARCHAR (20)    NULL,
    [NUMBER_OF_RECORDS]         INT             NULL,
    [EDM_SEC_ID]                INT             NULL,
    [SECURITY_IDENTIFIER_FLAG]  INT             NULL,
    [FIRM_IDENTIFIER]           VARCHAR (20)    NULL,
    [TICKER]                    VARCHAR (20)    NULL,
    [ISIN_NUMBER]               VARCHAR (12)    NULL,
    [UNIQUE_IDENTIFIER]         VARCHAR (30)    NOT NULL,
    [PARSEYEABLE_DESCRIPTION]   VARCHAR (20)    NULL,
    [BID_PRICE]                 DECIMAL (18, 6) NULL,
    [ASK_PRICE]                 DECIMAL (18, 6) NULL,
    [MID_PRICE]                 DECIMAL (18, 6) NULL,
    [DATE_OF_LAST_UPDATE]       DATETIME        NULL,
    [YESTERDAY_CLOSE_PRICE]     DECIMAL (18, 2) NULL,
    [TIME_OF_LAST_UPDATE]       VARCHAR (20)    NULL,
    [NET_CURRENT_POSITION]      DECIMAL (18, 2) NULL,
    [SHORT_NAME]                VARCHAR (20)    NULL,
    [SECURITY_TYPE]             VARCHAR (20)    NULL,
    [CLOSING_MID/TRADE_PRICE]   DECIMAL (18, 2) NULL,
    [AVERAGE_COST]              DECIMAL (18, 2) NULL,
    [PRICE_IS_PENCE_QUOTED]     VARCHAR (20)    NULL,
    [CURRENCY]                  VARCHAR (20)    NULL,
    [FX_RATE]                   DECIMAL (18, 4) NULL,
    [MARKET_VALUE]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([UNIQUE_IDENTIFIER] ASC)
);

