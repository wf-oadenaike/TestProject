﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFI_NT_PREP] (
    [VALUATION_DATE]         DATETIME         NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (20)     NOT NULL,
    [UNITS]                  DECIMAL (28, 10) NOT NULL,
    [FUND_NET_INCOME]        DECIMAL (28, 10) NOT NULL,
    [RATE]                   DECIMAL (23, 15) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_RUNID]     INT              NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([VALUATION_DATE] ASC, [FUND_SHORT_NAME] ASC) WITH (FILLFACTOR = 80)
);

