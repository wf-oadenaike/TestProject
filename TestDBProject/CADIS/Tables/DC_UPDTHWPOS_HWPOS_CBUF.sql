﻿CREATE TABLE [CADIS].[DC_UPDTHWPOS_HWPOS_CBUF] (
    [MODEL_CODE]         VARCHAR (20) NOT NULL,
    [INSTRUMENT_UII]     VARCHAR (12) NOT NULL,
    [CURRENT_DATE]       DATETIME     NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([MODEL_CODE] ASC, [INSTRUMENT_UII] ASC, [CURRENT_DATE] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID208]
    ON [CADIS].[DC_UPDTHWPOS_HWPOS_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

