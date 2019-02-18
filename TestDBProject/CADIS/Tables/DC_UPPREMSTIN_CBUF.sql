﻿CREATE TABLE [CADIS].[DC_UPPREMSTIN_CBUF] (
    [FUND_SHORT_NAME]     VARCHAR (50) NOT NULL,
    [EDM_SEC_ID]          INT          NOT NULL,
    [FUND_FISCAL_YEAR]    INT          NOT NULL,
    [FUND_FISCAL_QUARTER] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [FUND_FISCAL_YEAR] ASC, [FUND_FISCAL_QUARTER] ASC) WITH (FILLFACTOR = 80)
);

