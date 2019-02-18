﻿CREATE TABLE [CADIS].[DC_OSTCOV_ACTIVESTAT_CBUF] (
    [sfContactId]        VARCHAR (18) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID163]
    ON [CADIS].[DC_OSTCOV_ACTIVESTAT_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

