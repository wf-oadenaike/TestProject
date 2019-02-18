﻿CREATE TABLE [CADIS_SYS].[MG_FUNCTION] (
    [GUID]       NCHAR (32)     NOT NULL,
    [NAME]       NVARCHAR (100) NOT NULL,
    [IDENTIFIER] INT            IDENTITY (1, 1) NOT NULL,
    [DETAILS]    IMAGE          NULL,
    [OBSOLETE]   TINYINT        CONSTRAINT [DF_MG_FUNCTION_OBSOLETE] DEFAULT ((0)) NOT NULL,
    [INSERTED]   DATETIME       NOT NULL,
    [UPDATED]    DATETIME       NOT NULL,
    [CHANGEDBY]  NVARCHAR (100) NOT NULL,
    [CODE]       NVARCHAR (10)  DEFAULT ('') NOT NULL,
    [DEFINITION] XML            NULL,
    [CRC]        NCHAR (64)     NULL,
    [ENABLED]    BIT            DEFAULT ((1)) NOT NULL,
    [TIMECODE]   VARCHAR (17)   NOT NULL,
    CONSTRAINT [PK_MG_FUNCTION] PRIMARY KEY NONCLUSTERED ([GUID] ASC),
    CONSTRAINT [UKCADIS_SYSTEM_MG1] UNIQUE NONCLUSTERED ([NAME] ASC, [OBSOLETE] ASC)
);


GO
CREATE UNIQUE CLUSTERED INDEX [IDXFUNCTIONID]
    ON [CADIS_SYS].[MG_FUNCTION]([IDENTIFIER] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDXFUNCTIONOBSOLETE]
    ON [CADIS_SYS].[MG_FUNCTION]([NAME] ASC, [OBSOLETE] ASC);

