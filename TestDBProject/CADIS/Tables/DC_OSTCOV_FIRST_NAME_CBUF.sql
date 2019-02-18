﻿CREATE TABLE [CADIS].[DC_OSTCOV_FIRST_NAME_CBUF] (
    [sfContactId]        VARCHAR (18) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([sfContactId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID160]
    ON [CADIS].[DC_OSTCOV_FIRST_NAME_CBUF]([CADIS_SYSTEM_RUNID] ASC);

