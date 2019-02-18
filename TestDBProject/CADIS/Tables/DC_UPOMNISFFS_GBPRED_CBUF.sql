﻿CREATE TABLE [CADIS].[DC_UPOMNISFFS_GBPRED_CBUF] (
    [ROW_NUMBER]         INT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID102]
    ON [CADIS].[DC_UPOMNISFFS_GBPRED_CBUF]([CADIS_SYSTEM_RUNID] ASC);

