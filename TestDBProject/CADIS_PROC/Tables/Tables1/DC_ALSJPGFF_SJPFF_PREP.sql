﻿CREATE TABLE [CADIS_PROC].[DC_ALSJPGFF_SJPFF_PREP] (
    [ROW_NUMBER]                INT             NOT NULL,
    [TYPE]                      VARCHAR (20)    NOT NULL,
    [FUND_CODE_A]               VARCHAR (50)    NULL,
    [FUND_CODE_B]               VARCHAR (50)    NULL,
    [FUND_NAME]                 VARCHAR (50)    NULL,
    [STATIC_DATA]               VARCHAR (15)    NULL,
    [TRADE_DATE]                DATETIME        NULL,
    [CREATION_CASH_GBP]         DECIMAL (18, 2) NULL,
    [CREATION_CASH_USD]         DECIMAL (18, 2) NULL,
    [CREATION_CASH_EUR]         DECIMAL (18, 2) NULL,
    [CANCELLATION_CASH_GBP]     DECIMAL (18, 2) NULL,
    [CANCELLATION_CASH_USD]     DECIMAL (18, 2) NULL,
    [CANCELLATION_CASH_EUR]     DECIMAL (18, 2) NULL,
    [SETTLE_DATE]               DATETIME        NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        NULL,
    [FUND_FLOW_TYPE]            VARCHAR (5)     NOT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC) WITH (FILLFACTOR = 80)
);

