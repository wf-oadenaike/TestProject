CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT693] (
    [ID]                                 INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]                         INT             NOT NULL,
    [INSERTED]                           DATETIME        NOT NULL,
    [CHANGEDBY]                          NVARCHAR (256)  NOT NULL,
    [FIELDNAME]                          NVARCHAR (200)  NOT NULL,
    [ACTION]                             TINYINT         NOT NULL,
    [OLDVALUE]                           NVARCHAR (4000) NULL,
    [NEWVALUE]                           NVARCHAR (4000) NULL,
    [VALIDATION]                         NVARCHAR (4000) NULL,
    [KEY_HuddleControlLogRelationshipId] INT             NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT693] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT693]([INSERTED] ASC) WITH (FILLFACTOR = 80);

