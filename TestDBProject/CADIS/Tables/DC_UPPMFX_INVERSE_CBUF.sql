﻿CREATE TABLE [CADIS].[DC_UPPMFX_INVERSE_CBUF] (
    [FXRATE_ID]          VARCHAR (40) NOT NULL,
    [FROM DATE]          DATE         NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([FXRATE_ID] ASC, [FROM DATE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID19]
    ON [CADIS].[DC_UPPMFX_INVERSE_CBUF]([CADIS_SYSTEM_RUNID] ASC);

