﻿CREATE TABLE [CADIS].[DC_PPSJPGRFF_USDSUB_CBUF] (
    [ROW_NUMBER]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID106]
    ON [CADIS].[DC_PPSJPGRFF_USDSUB_CBUF]([CADIS_SYSTEM_RUNID] ASC);

