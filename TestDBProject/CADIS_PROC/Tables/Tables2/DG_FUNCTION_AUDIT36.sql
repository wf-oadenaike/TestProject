CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT36] (
    [ID]                            INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]                    INT             NOT NULL,
    [INSERTED]                      DATETIME        NOT NULL,
    [CHANGEDBY]                     NVARCHAR (256)  NOT NULL,
    [FIELDNAME]                     NVARCHAR (200)  NOT NULL,
    [ACTION]                        TINYINT         NOT NULL,
    [OLDVALUE]                      NVARCHAR (MAX)  NULL,
    [NEWVALUE]                      NVARCHAR (MAX)  NULL,
    [VALIDATION]                    NVARCHAR (4000) NULL,
    [KEY_ConflictsRegisterActionId] INT             NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT36] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT36]([INSERTED] ASC);

