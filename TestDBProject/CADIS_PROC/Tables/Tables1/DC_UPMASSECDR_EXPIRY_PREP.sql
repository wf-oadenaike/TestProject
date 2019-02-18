﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECDR_EXPIRY_PREP] (
    [EDM_SEC_ID]               INT           NOT NULL,
    [OPTION_ROOT_TICKER]       DATETIME      NULL,
    [PUT_CALL_INDICATOR]       DATETIME      NULL,
    [EXPIRY_DATE]              DATETIME      NULL,
    [FUTURE_EXPIRY_MONTH_YEAR] DATETIME      NULL,
    [EXERCISE_TYPE]            DATETIME      NULL,
    [CONTRACT_SIZE]            DATETIME      NULL,
    [CONTRACT_VALUE]           DATETIME      NULL,
    [FUTURE_TYPE]              DATETIME      NULL,
    [LAST_TRADE_DATE]          DATETIME      NULL,
    [LONG_EXCHANGE_NAME]       DATETIME      NULL,
    [DELTA]                    DATETIME      NULL,
    [GAMMA]                    DATETIME      NULL,
    [THETA]                    DATETIME      NULL,
    [VEGA]                     DATETIME      NULL,
    [EURO_FUTURE_INDICATOR]    DATETIME      NULL,
    [CONVERSION_FACTOR]        DATETIME      NULL,
    [CTD_CONVERSION_DURATION]  DATETIME      NULL,
    [CTD_ISIN]                 DATETIME      NULL,
    [CTD_SEDOL]                DATETIME      NULL,
    [CTD_RISK_TYPE]            DATETIME      NULL,
    [FUTURE_DAYS_TO_EXPIRY]    DATETIME      NULL,
    [FUTURE_LONGNAME]          DATETIME      NULL,
    [STRIKE_PRICE]             DATETIME      NULL,
    [TICK_SIZE]                DATETIME      NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]    INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP]   ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

