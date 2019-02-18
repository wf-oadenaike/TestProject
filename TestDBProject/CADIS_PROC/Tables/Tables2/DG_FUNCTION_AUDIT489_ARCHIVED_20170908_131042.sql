CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT489_ARCHIVED_20170908_131042] (
    [ID]                  INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]          INT             NOT NULL,
    [INSERTED]            DATETIME        NOT NULL,
    [CHANGEDBY]           NVARCHAR (256)  NOT NULL,
    [FIELDNAME]           NVARCHAR (200)  NOT NULL,
    [ACTION]              TINYINT         NOT NULL,
    [OLDVALUE]            NVARCHAR (4000) NULL,
    [NEWVALUE]            NVARCHAR (4000) NULL,
    [VALIDATION]          NVARCHAR (4000) NULL,
    [KEY_EDM_SEC_ID]      INT             NULL,
    [KEY_BBG_EX_DATE]     DATETIME        NULL,
    [KEY_FUND_SHORT_NAME] VARCHAR (50)    NOT NULL
);

