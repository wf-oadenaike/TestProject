﻿CREATE TABLE [CADIS].[DC_UPSECEXP_EXISTING_CBUF] (
    [SOURCE_TABLE]       VARCHAR (50) NOT NULL,
    [SOURCE_KEY]         VARCHAR (50) NOT NULL,
    [SOURCE_COLUMN]      VARCHAR (50) NOT NULL,
    [EXCEPTION_CODE]     INT          NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([SOURCE_TABLE] ASC, [SOURCE_KEY] ASC, [SOURCE_COLUMN] ASC, [EXCEPTION_CODE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID148]
    ON [CADIS].[DC_UPSECEXP_EXISTING_CBUF]([CADIS_SYSTEM_RUNID] ASC);

