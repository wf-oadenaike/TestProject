﻿CREATE TABLE [CADIS].[DC_PRESECEQ_HWSEC_CBUF] (
    [INSTRUMENT_UII]     VARCHAR (12) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([INSTRUMENT_UII] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID212]
    ON [CADIS].[DC_PRESECEQ_HWSEC_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);
