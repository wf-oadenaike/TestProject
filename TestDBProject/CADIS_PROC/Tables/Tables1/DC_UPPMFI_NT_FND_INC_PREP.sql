﻿CREATE TABLE [CADIS_PROC].[DC_UPPMFI_NT_FND_INC_PREP] (
    [FUND_SHORT_NAME]        VARCHAR (20)     NOT NULL,
    [VALUATION_DATE]         DATETIME         NOT NULL,
    [UNITS]                  DECIMAL (28, 10) NOT NULL,
    [FUND_NET_INCOME]        DECIMAL (28, 10) NOT NULL,
    [RATE]                   DECIMAL (28, 10) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_RUNID]     INT              NOT NULL,
    [CADIS_SYSTEM_TOPRUNID]  INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [VALUATION_DATE] ASC) WITH (FILLFACTOR = 80)
);

