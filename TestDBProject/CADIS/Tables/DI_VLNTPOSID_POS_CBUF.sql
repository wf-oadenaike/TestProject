﻿CREATE TABLE [CADIS].[DI_VLNTPOSID_POS_CBUF] (
    [ROW_NUMBER]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID50]
    ON [CADIS].[DI_VLNTPOSID_POS_CBUF]([CADIS_SYSTEM_RUNID] ASC);

