﻿CREATE TABLE [CADIS].[DC_UPPMFI_NT_STAGE_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (20) NOT NULL,
    [VALUATION_DATE]     DATETIME     NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [VALUATION_DATE] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID250]
    ON [CADIS].[DC_UPPMFI_NT_STAGE_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

