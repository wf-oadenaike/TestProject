﻿CREATE TABLE [CADIS].[DC_ENRICH_BBGPRCEOD_CBUF] (
    [UNIQUE_IDENTIFIER]  VARCHAR (30) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([UNIQUE_IDENTIFIER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID33]
    ON [CADIS].[DC_ENRICH_BBGPRCEOD_CBUF]([CADIS_SYSTEM_RUNID] ASC);

