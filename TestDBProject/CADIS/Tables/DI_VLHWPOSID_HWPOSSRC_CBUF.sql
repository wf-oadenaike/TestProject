﻿CREATE TABLE [CADIS].[DI_VLHWPOSID_HWPOSSRC_CBUF] (
    [MODEL_CODE]         VARCHAR (20) NOT NULL,
    [MODEL_DATE]         DATETIME     NOT NULL,
    [INSTRUMENT_UII]     VARCHAR (12) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([MODEL_CODE] ASC, [MODEL_DATE] ASC, [INSTRUMENT_UII] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID204]
    ON [CADIS].[DI_VLHWPOSID_HWPOSSRC_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

