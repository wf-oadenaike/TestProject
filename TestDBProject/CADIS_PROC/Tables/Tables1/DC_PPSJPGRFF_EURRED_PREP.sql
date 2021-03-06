﻿CREATE TABLE [CADIS_PROC].[DC_PPSJPGRFF_EURRED_PREP] (
    [ROW_NUMBER]            INT             NOT NULL,
    [FUND_CODE_A]           VARCHAR (50)    NULL,
    [FUND_CODE_B]           VARCHAR (50)    NULL,
    [FUND_NAME]             VARCHAR (50)    NULL,
    [STATIC_DATA]           VARCHAR (15)    NULL,
    [TRADE_DATE]            DATETIME        NULL,
    [SETTLE_DATE]           DATETIME        NULL,
    [CANCELLATION_CASH_EUR] DECIMAL (38, 2) NULL,
    [CADIS_SYSTEM_UPDATED]  DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC) WITH (FILLFACTOR = 80)
);

