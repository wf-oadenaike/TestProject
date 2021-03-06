﻿CREATE TABLE [CADIS].[DC_UPMSTDVDFC_RESET_CBUF] (
    [Fund Short Name]    VARCHAR (20) NOT NULL,
    [EDM_SEC_ID]         INT          NOT NULL,
    [Calendar Year]      INT          NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([Fund Short Name] ASC, [EDM_SEC_ID] ASC, [Calendar Year] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID227]
    ON [CADIS].[DC_UPMSTDVDFC_RESET_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

