﻿CREATE TABLE [CADIS].[DC_ALLOC_ALLOC_CBUF] (
    [FileName]           VARCHAR (256) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT           NULL,
    PRIMARY KEY CLUSTERED ([FileName] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID192]
    ON [CADIS].[DC_ALLOC_ALLOC_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

