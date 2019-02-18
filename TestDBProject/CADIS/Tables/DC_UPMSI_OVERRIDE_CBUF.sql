﻿CREATE TABLE [CADIS].[DC_UPMSI_OVERRIDE_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]         INT          NOT NULL,
    [FUND_FISCAL_YEAR]   INT          NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [EDM_SEC_ID] ASC, [FUND_FISCAL_YEAR] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID242]
    ON [CADIS].[DC_UPMSI_OVERRIDE_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

