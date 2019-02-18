﻿CREATE TABLE [CADIS].[DC_UPPNSTATUS_NOTIFICAT_CBUF] (
    [DATA_CHANNEL_ID]    INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([DATA_CHANNEL_ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID1]
    ON [CADIS].[DC_UPPNSTATUS_NOTIFICAT_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);
