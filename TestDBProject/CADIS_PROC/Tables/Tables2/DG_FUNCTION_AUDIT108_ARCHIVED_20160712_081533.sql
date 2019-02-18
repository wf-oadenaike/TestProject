CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT108_ARCHIVED_20160712_081533] (
    [ID]                       INT              IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]               INT              NOT NULL,
    [INSERTED]                 DATETIME         NOT NULL,
    [CHANGEDBY]                NVARCHAR (256)   NOT NULL,
    [FIELDNAME]                NVARCHAR (200)   NOT NULL,
    [ACTION]                   TINYINT          NOT NULL,
    [OLDVALUE]                 NVARCHAR (4000)  NULL,
    [NEWVALUE]                 NVARCHAR (4000)  NULL,
    [VALIDATION]               NVARCHAR (4000)  NULL,
    [KEY_UnquotedSecuritiesId] INT              NOT NULL,
    [KEY_UnquotedCompanyId]    INT              NOT NULL,
    [KEY_WorkflowVersionGUID]  UNIQUEIDENTIFIER NULL
);

