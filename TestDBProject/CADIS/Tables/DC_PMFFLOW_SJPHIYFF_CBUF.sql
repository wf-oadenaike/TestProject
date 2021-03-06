﻿CREATE TABLE [CADIS].[DC_PMFFLOW_SJPHIYFF_CBUF] (
    [ROW_NUMBER]         INT          NOT NULL,
    [TYPE]               VARCHAR (20) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([ROW_NUMBER] ASC, [TYPE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID90]
    ON [CADIS].[DC_PMFFLOW_SJPHIYFF_CBUF]([CADIS_SYSTEM_RUNID] ASC);

