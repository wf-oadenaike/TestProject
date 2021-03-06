﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFNDMKT_FUND_PREP] (
    [SOURCE]                          VARCHAR (2)     NOT NULL,
    [POSITION_TYPE]                   VARCHAR (8)     NOT NULL,
    [STATUS]                          VARCHAR (9)     NOT NULL,
    [ACCOUNT_NUMBER_NT]               VARCHAR (6)     NOT NULL,
    [D_VALN_OUT_DATE]                 DATETIME        NOT NULL,
    [FUND_SHORT_NAME]                 VARCHAR (15)    NOT NULL,
    [TOTAL_MARKET_VALUE_LOCAL]        DECIMAL (38, 5) NULL,
    [TOTAL_MARKET_VALUE_BASE]         DECIMAL (38, 5) NULL,
    [TOTAL_ACCRUED_MARKET_VALUE_BASE] DECIMAL (38, 5) NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [POSITION_TYPE] ASC, [D_VALN_OUT_DATE] ASC, [FUND_SHORT_NAME] ASC) WITH (FILLFACTOR = 80)
);

