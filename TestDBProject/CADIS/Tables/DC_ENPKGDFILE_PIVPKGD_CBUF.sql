﻿CREATE TABLE [CADIS].[DC_ENPKGDFILE_PIVPKGD_CBUF] (
    [TOPLEVELRUNID]      INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([TOPLEVELRUNID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID194]
    ON [CADIS].[DC_ENPKGDFILE_PIVPKGD_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

