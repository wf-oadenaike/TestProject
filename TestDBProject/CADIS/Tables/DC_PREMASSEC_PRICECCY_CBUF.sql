﻿CREATE TABLE [CADIS].[DC_PREMASSEC_PRICECCY_CBUF] (
    [EDM_SEC_ID]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID193]
    ON [CADIS].[DC_PREMASSEC_PRICECCY_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);
