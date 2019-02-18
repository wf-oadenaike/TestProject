﻿CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT191] (
    [ID]             INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]     INT             NOT NULL,
    [INSERTED]       DATETIME        NOT NULL,
    [CHANGEDBY]      NVARCHAR (256)  NOT NULL,
    [FIELDNAME]      NVARCHAR (200)  NOT NULL,
    [ACTION]         TINYINT         NOT NULL,
    [OLDVALUE]       NVARCHAR (4000) NULL,
    [NEWVALUE]       NVARCHAR (4000) NULL,
    [VALIDATION]     NVARCHAR (4000) NULL,
    [KEY_EDM_SEC_ID] INT             NOT NULL,
    [KEY_PRICE_TYPE] VARCHAR (50)    NOT NULL,
    [KEY_PRICE_DATE] DATETIME        NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT191] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT191]([INSERTED] ASC);

