﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECDR_INFO_RUNID] (
    [EDM_SEC_ID]                      INT NOT NULL,
    [OPTION_ROOT_TICKER__RUNID]       INT NOT NULL,
    [PUT_CALL_INDICATOR__RUNID]       INT NOT NULL,
    [EXPIRY_DATE__RUNID]              INT NOT NULL,
    [FUTURE_EXPIRY_MONTH_YEAR__RUNID] INT NOT NULL,
    [EXERCISE_TYPE__RUNID]            INT NOT NULL,
    [CONTRACT_SIZE__RUNID]            INT NOT NULL,
    [CONTRACT_VALUE__RUNID]           INT NOT NULL,
    [FUTURE_TYPE__RUNID]              INT NOT NULL,
    [LAST_TRADE_DATE__RUNID]          INT NOT NULL,
    [LONG_EXCHANGE_NAME__RUNID]       INT NOT NULL,
    [DELTA__RUNID]                    INT NOT NULL,
    [GAMMA__RUNID]                    INT NOT NULL,
    [THETA__RUNID]                    INT NOT NULL,
    [VEGA__RUNID]                     INT NOT NULL,
    [EURO_FUTURE_INDICATOR__RUNID]    INT NOT NULL,
    [CONVERSION_FACTOR__RUNID]        INT NOT NULL,
    [CTD_CONVERSION_DURATION__RUNID]  INT NOT NULL,
    [CTD_ISIN__RUNID]                 INT NOT NULL,
    [CTD_SEDOL__RUNID]                INT NOT NULL,
    [CTD_RISK_TYPE__RUNID]            INT NOT NULL,
    [FUTURE_DAYS_TO_EXPIRY__RUNID]    INT NOT NULL,
    [FUTURE_LONGNAME__RUNID]          INT NOT NULL,
    [STRIKE_PRICE__RUNID]             INT NOT NULL,
    [TICK_SIZE__RUNID]                INT NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);

