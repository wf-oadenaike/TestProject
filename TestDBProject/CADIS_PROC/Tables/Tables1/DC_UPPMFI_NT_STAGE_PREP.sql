﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFI_NT_STAGE_PREP] (
    [FUND_SHORT_NAME] VARCHAR (20)     NOT NULL,
    [VALUATION_DATE]  DATETIME         NOT NULL,
    [UNITS]           DECIMAL (18, 4)  NULL,
    [FUND_NET_INCOME] DECIMAL (18, 4)  NULL,
    [RATE]            DECIMAL (23, 15) NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [VALUATION_DATE] ASC) WITH (FILLFACTOR = 80)
);
