CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT103] (
    [ID]                       INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]               INT             NOT NULL,
    [INSERTED]                 DATETIME        NOT NULL,
    [CHANGEDBY]                NVARCHAR (256)  NOT NULL,
    [FIELDNAME]                NVARCHAR (200)  NOT NULL,
    [ACTION]                   TINYINT         NOT NULL,
    [OLDVALUE]                 NVARCHAR (4000) NULL,
    [NEWVALUE]                 NVARCHAR (4000) NULL,
    [VALIDATION]               NVARCHAR (4000) NULL,
    [KEY_UnquotedCompanyStage] VARCHAR (5)     NOT NULL,
    [KEY_RoleId]               SMALLINT        NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT103] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT103]([INSERTED] ASC);

