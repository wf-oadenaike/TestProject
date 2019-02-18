﻿CREATE TABLE [CADIS_PROC].[DC_UPNTEIFS_STAGE_PREP] (
    [VALUATION_DATE]  DATETIME         NOT NULL,
    [FUND_SHORT_NAME] VARCHAR (20)     NOT NULL,
    [UNITS]           DECIMAL (18, 4)  NULL,
    [FUND_NET_INCOME] DECIMAL (18, 4)  NULL,
    [RATE]            DECIMAL (23, 15) NULL,
    PRIMARY KEY CLUSTERED ([VALUATION_DATE] ASC, [FUND_SHORT_NAME] ASC) WITH (FILLFACTOR = 80)
);

