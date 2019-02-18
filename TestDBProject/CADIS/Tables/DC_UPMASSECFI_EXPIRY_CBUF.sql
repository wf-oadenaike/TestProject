﻿CREATE TABLE [CADIS].[DC_UPMASSECFI_EXPIRY_CBUF] (
    [EDM_SEC_ID]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID55]
    ON [CADIS].[DC_UPMASSECFI_EXPIRY_CBUF]([CADIS_SYSTEM_RUNID] ASC);

