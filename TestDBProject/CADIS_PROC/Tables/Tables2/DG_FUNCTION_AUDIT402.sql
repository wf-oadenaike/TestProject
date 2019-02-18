CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT402] (
    [ID]                      INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]              INT             NOT NULL,
    [INSERTED]                DATETIME        NOT NULL,
    [CHANGEDBY]               NVARCHAR (256)  NOT NULL,
    [FIELDNAME]               NVARCHAR (200)  NOT NULL,
    [ACTION]                  TINYINT         NOT NULL,
    [OLDVALUE]                NVARCHAR (4000) NULL,
    [NEWVALUE]                NVARCHAR (4000) NULL,
    [VALIDATION]              NVARCHAR (4000) NULL,
    [KEY_ComplaintRegisterId] INT             NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT402] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT402]([INSERTED] ASC);

