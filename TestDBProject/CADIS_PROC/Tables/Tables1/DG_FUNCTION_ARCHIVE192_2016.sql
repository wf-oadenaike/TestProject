﻿CREATE TABLE [CADIS_PROC].[DG_FUNCTION_ARCHIVE192_2016] (
    [ID]                    INT             NOT NULL,
    [IDENTIFIER]            INT             NOT NULL,
    [INSERTED]              DATETIME        NOT NULL,
    [CHANGEDBY]             NVARCHAR (256)  NOT NULL,
    [FIELDNAME]             NVARCHAR (200)  NOT NULL,
    [ACTION]                TINYINT         NOT NULL,
    [OLDVALUE]              NVARCHAR (4000) NULL,
    [NEWVALUE]              NVARCHAR (4000) NULL,
    [VALIDATION]            NVARCHAR (4000) NULL,
    [CADIS_SYSTEM_ARCHIVED] DATETIME        NULL,
    [KEY_EDM_SEC_ID]        INT             NOT NULL,
    [KEY_PRICE_TYPE]        VARCHAR (50)    NOT NULL,
    [KEY_PRICE_DATE]        DATETIME        NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_ARCHIVE192_2016]([INSERTED] ASC);

