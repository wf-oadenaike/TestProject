﻿CREATE TABLE [CADIS].[DC_UPMSTPTY_OVERRIDE_CBUF] (
    [EDM_PTY_ID]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_PTY_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID11]
    ON [CADIS].[DC_UPMSTPTY_OVERRIDE_CBUF]([CADIS_SYSTEM_RUNID] ASC);

