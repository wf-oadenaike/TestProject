﻿CREATE TABLE [CADIS].[DC_UPMSCV_CBUF] (
    [EDM_SHARECLASS_ID] INT      NOT NULL,
    [VALUATION_DATE]    DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SHARECLASS_ID] ASC, [VALUATION_DATE] ASC) WITH (FILLFACTOR = 80)
);

