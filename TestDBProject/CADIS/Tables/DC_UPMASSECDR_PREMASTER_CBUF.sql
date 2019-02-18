﻿CREATE TABLE [CADIS].[DC_UPMASSECDR_PREMASTER_CBUF] (
    [EDM_SEC_ID]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID59]
    ON [CADIS].[DC_UPMASSECDR_PREMASTER_CBUF]([CADIS_SYSTEM_RUNID] ASC);

