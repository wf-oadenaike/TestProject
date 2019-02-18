﻿CREATE TABLE [CADIS].[DC_OSTNAO_OVERRIDE_CBUF] (
    [MatrixOutletId]     VARCHAR (50) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([MatrixOutletId] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID170]
    ON [CADIS].[DC_OSTNAO_OVERRIDE_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

