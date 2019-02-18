﻿CREATE TABLE [CADIS].[DC_OSTCOV_MOBILE_CBUF] (
    [sfContactId]        VARCHAR (18) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID165]
    ON [CADIS].[DC_OSTCOV_MOBILE_CBUF]([CADIS_SYSTEM_RUNID] ASC);
