﻿CREATE TABLE [CADIS_PROC].[DC_OWNTEIFS_CBUF] (
    [VALUATION_DATE]  DATETIME     NOT NULL,
    [FUND_SHORT_NAME] VARCHAR (20) NOT NULL,
    PRIMARY KEY CLUSTERED ([VALUATION_DATE] ASC, [FUND_SHORT_NAME] ASC) WITH (FILLFACTOR = 80)
);

