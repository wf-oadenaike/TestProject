﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECEQ_PREMASTER_PREP] (
    [EDM_SEC_ID]                         INT              NOT NULL,
    [EX_DIVIDEND_DATE]                   DATETIME         NULL,
    [DIVIDEND_FREQUENCY]                 VARCHAR (20)     NULL,
    [DIVIDEND_PAY_DATE]                  DATETIME         NULL,
    [DIVIDEND_PER_SHARE_LAST_NET]        DECIMAL (26, 12) NULL,
    [DIVIDEND_PER_SHARE_LAST_GROSS]      DECIMAL (26, 12) NULL,
    [DIVIDEND_PER_SHARE_ANNUAL_GROSS]    DECIMAL (26, 6)  NULL,
    [DIVIDEND_TYPE]                      VARCHAR (30)     NULL,
    [DIVIDEND_RECORD_DATE]               DATETIME         NULL,
    [CURRENT_STOCK_DIVIDEND_EX_DATE]     DATETIME         NULL,
    [CURRENT_STOCK_DIVIDEND_PAY_DATE]    DATETIME         NULL,
    [CURRENT_STOCK_DIVIDEND_PCT]         VARCHAR (10)     NULL,
    [NORMAL_MARKET_SIZE]                 DECIMAL (26, 6)  NULL,
    [SHARES_OUTSTANDING]                 DECIMAL (26, 6)  NULL,
    [SHARES_OUTSTANDING_DATE]            DATETIME         NULL,
    [VOL_WEIGHTED_AVERAGE_PRICE]         DECIMAL (26, 6)  NULL,
    [FUND_NET_ASSET_VALUE]               DECIMAL (26, 6)  NULL,
    [FUND_TOTAL_ASSETS]                  DECIMAL (26, 6)  NULL,
    [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE] DATETIME         NULL,
    [TOTAL_VOTING_SHARES]                DECIMAL (26, 6)  NULL,
    [CADIS_SYSTEM_INSERTED]              DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]               DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]             NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_PRIORITY]              INT              NULL,
    [CADIS_SYSTEM_LASTMODIFIED]          DATETIME         NULL,
    [SHARE_OUTSTANDING_REAL_ACTUAL]      VARCHAR (20)     NULL,
    [TOTAL_VOTING_SHARES_VALUE]          VARCHAR (20)     NULL,
    [LAST_PUBLISHED_OFFER_NO_OF_SHARES]  VARCHAR (20)     NULL,
    [SHARE_OUTSTANDING_REAL_VALUE]       VARCHAR (20)     NULL,
    [CURRENT_MARKET_CAP]                 VARCHAR (20)     NULL,
    [EQUITY_UNDERLYING_TICKER]           VARCHAR (26)     NULL,
    [DIVIDEND_CCY]                       VARCHAR (10)     NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

