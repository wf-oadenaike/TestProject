﻿CREATE TABLE [CADIS_PROC].[DC_UPMASSECDR_PREMASTER_PREP] (
    [EDM_SEC_ID]                INT             NOT NULL,
    [OPTION_ROOT_TICKER]        VARCHAR (10)    NULL,
    [PUT_CALL_INDICATOR]        VARCHAR (8)     NULL,
    [EXPIRY_DATE]               DATETIME        NULL,
    [FUTURE_EXPIRY_MONTH_YEAR]  VARCHAR (10)    NULL,
    [EXERCISE_TYPE]             VARCHAR (8)     NULL,
    [CONTRACT_SIZE]             DECIMAL (26, 6) NULL,
    [CONTRACT_VALUE]            DECIMAL (26, 6) NULL,
    [FUTURE_TYPE]               VARCHAR (30)    NULL,
    [LAST_TRADE_DATE]           DATETIME        NULL,
    [LONG_EXCHANGE_NAME]        VARCHAR (30)    NULL,
    [DELTA]                     DECIMAL (26, 6) NULL,
    [GAMMA]                     DECIMAL (26, 6) NULL,
    [THETA]                     DECIMAL (26, 6) NULL,
    [VEGA]                      DECIMAL (26, 6) NULL,
    [EURO_FUTURE_INDICATOR]     VARCHAR (1)     NULL,
    [CONVERSION_FACTOR]         DECIMAL (26, 6) NULL,
    [CTD_CONVERSION_DURATION]   DECIMAL (26, 6) NULL,
    [CTD_ISIN]                  VARCHAR (12)    NULL,
    [CTD_SEDOL]                 VARCHAR (7)     NULL,
    [CTD_RISK_TYPE]             VARCHAR (20)    NULL,
    [FUTURE_DAYS_TO_EXPIRY]     INT             NULL,
    [FUTURE_LONGNAME]           VARCHAR (30)    NULL,
    [STRIKE_PRICE]              DECIMAL (26, 6) NULL,
    [TICK_SIZE]                 DECIMAL (26, 6) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);

