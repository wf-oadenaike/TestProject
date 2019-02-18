﻿CREATE TABLE [CADIS_PROC].[DC_UPPMSECDER_INFO_RULE] (
    [EDM_SEC_ID]                       INT NOT NULL,
    [OPTION_ROOT_TICKER__RULEID]       INT NULL,
    [PUT_CALL_INDICATOR__RULEID]       INT NULL,
    [EXPIRY_DATE__RULEID]              INT NULL,
    [FUTURE_EXPIRY_MONTH_YEAR__RULEID] INT NULL,
    [EXERCISE_TYPE__RULEID]            INT NULL,
    [CONTRACT_SIZE__RULEID]            INT NULL,
    [CONTRACT_VALUE__RULEID]           INT NULL,
    [FUTURE_TYPE__RULEID]              INT NULL,
    [LAST_TRADE_DATE__RULEID]          INT NULL,
    [LONG_EXCHANGE_NAME__RULEID]       INT NULL,
    [DELTA__RULEID]                    INT NULL,
    [GAMMA__RULEID]                    INT NULL,
    [THETA__RULEID]                    INT NULL,
    [VEGA__RULEID]                     INT NULL,
    [EURO_FUTURE_INDICATOR__RULEID]    INT NULL,
    [CONVERSION_FACTOR__RULEID]        INT NULL,
    [CTD_CONVERSION_DURATION__RULEID]  INT NULL,
    [CTD_ISIN__RULEID]                 INT NULL,
    [CTD_SEDOL__RULEID]                INT NULL,
    [CTD_RISK_TYPE__RULEID]            INT NULL,
    [FUTURE_DAYS_TO_EXPIRY__RULEID]    INT NULL,
    [FUTURE_LONGNAME__RULEID]          INT NULL,
    [STRIKE_PRICE__RULEID]             INT NULL,
    [TICK_SIZE__RULEID]                INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);
