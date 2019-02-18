﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECEQ_INFO_RULE] (
    [EDM_SEC_ID]                                 INT NOT NULL,
    [EX_DIVIDEND_DATE__RULEID]                   INT NULL,
    [DIVIDEND_FREQUENCY__RULEID]                 INT NULL,
    [DIVIDEND_PAY_DATE__RULEID]                  INT NULL,
    [DIVIDEND_PER_SHARE_LAST_NET__RULEID]        INT NULL,
    [DIVIDEND_PER_SHARE_LAST_GROSS__RULEID]      INT NULL,
    [DIVIDEND_PER_SHARE_ANNUAL_GROSS__RULEID]    INT NULL,
    [DIVIDEND_TYPE__RULEID]                      INT NULL,
    [DIVIDEND_RECORD_DATE__RULEID]               INT NULL,
    [CURRENT_STOCK_DIVIDEND_EX_DATE__RULEID]     INT NULL,
    [CURRENT_STOCK_DIVIDEND_PAY_DATE__RULEID]    INT NULL,
    [CURRENT_STOCK_DIVIDEND_PCT__RULEID]         INT NULL,
    [NORMAL_MARKET_SIZE__RULEID]                 INT NULL,
    [SHARES_OUTSTANDING__RULEID]                 INT NULL,
    [SHARES_OUTSTANDING_DATE__RULEID]            INT NULL,
    [IPO__RULEID]                                INT NULL,
    [VOL_WEIGHTED_AVERAGE_PRICE__RULEID]         INT NULL,
    [FUND_NET_ASSET_VALUE__RULEID]               INT NULL,
    [FUND_TOTAL_ASSETS__RULEID]                  INT NULL,
    [LAST_UPDATE_DATE_EXCHANGE_TIMEZONE__RULEID] INT NULL,
    [TOTAL_VOTING_SHARES__RULEID]                INT NULL,
    [SHARE_OUTSTANDING_REAL_ACTUAL__RULEID]      INT NULL,
    [TOTAL_VOTING_SHARES_VALUE__RULEID]          INT NULL,
    [LAST_PUBLISHED_OFFER_NO_OF_SHARES__RULEID]  INT NULL,
    [SHARE_OUTSTANDING_REAL_VALUE__RULEID]       INT NULL,
    [CURRENT_MARKET_CAP__RULEID]                 INT NULL,
    [EQUITY_UNDERLYING_TICKER__RULEID]           INT NULL,
    [DIVIDEND_CCY__RULEID]                       INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);

