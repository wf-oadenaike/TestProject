CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT489] (
    [ID]                        INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]                INT             NOT NULL,
    [INSERTED]                  DATETIME        NOT NULL,
    [CHANGEDBY]                 NVARCHAR (256)  NOT NULL,
    [FIELDNAME]                 NVARCHAR (200)  NOT NULL,
    [ACTION]                    TINYINT         NOT NULL,
    [OLDVALUE]                  NVARCHAR (4000) NULL,
    [NEWVALUE]                  NVARCHAR (4000) NULL,
    [VALIDATION]                NVARCHAR (4000) NULL,
    [KEY_DVD_Fund_Overrides_ID] INT             NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT489] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT489]([INSERTED] ASC);

