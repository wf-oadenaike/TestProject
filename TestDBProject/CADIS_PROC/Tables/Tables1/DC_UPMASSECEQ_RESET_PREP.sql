﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECEQ_RESET_PREP] (
    [EDM_SEC_ID]                         INT           NOT NULL,
    [EX_DIVIDEND_DATE]                   BIT           NULL,
    [DIVIDEND_FREQUENCY]                 BIT           NULL,
    [DIVIDEND_PAY_DATE]                  BIT           NULL,
    [DIVIDEND_PER_SHARE_LAST_NET]        BIT           NULL,
    [DIVIDEND_PER_SHARE_LAST_GROSS]      BIT           NULL,
    [DIVIDEND_PER_SHARE_ANNUAL_GROSS]    BIT           NULL,
    [DIVIDEND_TYPE]                      BIT           NULL,
    [DIVIDEND_RECORD_DATE]               BIT           NULL,
    [CURRENT_STOCK_DIVIDEND_EX_DATE]     BIT           NULL,
    [CURRENT_STOCK_DIVIDEND_PAY_DATE]    BIT           NULL,
    [CURRENT_STOCK_DIVIDEND_PCT]         BIT           NULL,
    [NORMAL_MARKET_SIZE]                 BIT           NULL,
    [SHARES_OUTSTANDING]                 BIT           NULL,
    [SHARES_OUTSTANDING_DATE]            BIT           NULL,
    [VOL_WEIGHTED_AVERAGE_PRICE]         BIT           NULL,
    [FUND_NET_ASSET_VALUE]               BIT           NULL,
    [FUND_TOTAL_ASSETS]                  BIT           NULL,
    [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE] BIT           NULL,
    [TOTAL_VOTING_SHARES]                BIT           NULL,
    [SHARE_OUTSTANDING_REAL_ACTUAL]      BIT           NULL,
    [TOTAL_VOTING_SHARES_VALUE]          BIT           NULL,
    [LAST_PUBLISHED_OFFER_NO_OF_SHARES]  BIT           NULL,
    [SHARE_OUTSTANDING_REAL_VALUE]       BIT           NULL,
    [CURRENT_MARKET_CAP]                 BIT           NULL,
    [CADIS_SYSTEM_INSERTED]              DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]               DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]             NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]              INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP]             ROWVERSION    NOT NULL,
    [EQUITY_UNDERLYING_TICKER]           BIT           NULL,
    [DIVIDEND_CCY]                       BIT           NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

