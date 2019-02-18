CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT324_ARCHIVED_20161116_110429] (
    [ID]                                    INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]                            INT             NOT NULL,
    [INSERTED]                              DATETIME        NOT NULL,
    [CHANGEDBY]                             NVARCHAR (256)  NOT NULL,
    [FIELDNAME]                             NVARCHAR (200)  NOT NULL,
    [ACTION]                                TINYINT         NOT NULL,
    [OLDVALUE]                              NVARCHAR (4000) NULL,
    [NEWVALUE]                              NVARCHAR (4000) NULL,
    [VALIDATION]                            NVARCHAR (4000) NULL,
    [KEY_InvestmentOpsDailyTasksRegisterId] INT             NOT NULL
);

