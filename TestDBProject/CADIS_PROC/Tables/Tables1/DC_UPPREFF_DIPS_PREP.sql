﻿CREATE TABLE [CADIS_PROC].[DC_UPPREFF_DIPS_PREP] (
    [TRANSACTION_DATE]     DATETIME        NOT NULL,
    [FLOW_TYPE]            VARCHAR (100)   NOT NULL,
    [MARKET_VALUE]         DECIMAL (38, 2) NULL,
    [CADIS_SYSTEM_UPDATED] DATETIME        NULL,
    [SOURCE]               VARCHAR (4)     NULL,
    [FUND_SHORT_NAME]      VARCHAR (50)    NOT NULL,
    [SOURCE_TYPE]          VARCHAR (11)    NOT NULL,
    PRIMARY KEY CLUSTERED ([TRANSACTION_DATE] ASC, [FLOW_TYPE] ASC, [FUND_SHORT_NAME] ASC, [SOURCE_TYPE] ASC) WITH (FILLFACTOR = 80)
);

