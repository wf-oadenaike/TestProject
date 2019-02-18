CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT732] (
    [ID]                              INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]                      INT             NOT NULL,
    [INSERTED]                        DATETIME        NOT NULL,
    [CHANGEDBY]                       NVARCHAR (256)  NOT NULL,
    [FIELDNAME]                       NVARCHAR (200)  NOT NULL,
    [ACTION]                          TINYINT         NOT NULL,
    [OLDVALUE]                        VARCHAR (MAX)   NULL,
    [NEWVALUE]                        VARCHAR (MAX)   NULL,
    [VALIDATION]                      NVARCHAR (4000) NULL,
    [KEY_ConflictsRegisterActionId_1] INT             NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT732] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT732]([INSERTED] ASC) WITH (FILLFACTOR = 80);

