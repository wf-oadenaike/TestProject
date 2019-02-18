﻿CREATE TABLE [CADIS_PROC].[DG_FUNCTION_ARCHIVE207_2016] (
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
    [KEY_FUND_SHORT_NAME]   VARCHAR (15)    NOT NULL,
    [KEY_TRANSACTION_DATE]  DATETIME        NOT NULL,
    [KEY_CURRENCY]          VARCHAR (20)    NOT NULL,
    [KEY_FUND_FLOW_TYPE]    VARCHAR (20)    NOT NULL,
    [KEY_FLOW_TYPE]         VARCHAR (100)   NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_ARCHIVE207_2016]([INSERTED] ASC);

