﻿CREATE TABLE [CADIS].[DC_UPPMSECDER_BBG_CBUF] (
    [UNIQUE_IDENTIFIER]  VARCHAR (30) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([UNIQUE_IDENTIFIER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID58]
    ON [CADIS].[DC_UPPMSECDER_BBG_CBUF]([CADIS_SYSTEM_RUNID] ASC);
