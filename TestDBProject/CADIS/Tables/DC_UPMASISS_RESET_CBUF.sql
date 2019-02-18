﻿CREATE TABLE [CADIS].[DC_UPMASISS_RESET_CBUF] (
    [EDM_Issuer_ID]      INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_Issuer_ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID225]
    ON [CADIS].[DC_UPMASISS_RESET_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);
