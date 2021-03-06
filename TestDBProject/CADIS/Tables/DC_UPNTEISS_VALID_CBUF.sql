﻿CREATE TABLE [CADIS].[DC_UPNTEISS_VALID_CBUF] (
    [ID]                 INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID256]
    ON [CADIS].[DC_UPNTEISS_VALID_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

