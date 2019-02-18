CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT15] (
    [ID]                    INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]            INT             NOT NULL,
    [INSERTED]              DATETIME        NOT NULL,
    [CHANGEDBY]             NVARCHAR (256)  NOT NULL,
    [FIELDNAME]             NVARCHAR (200)  NOT NULL,
    [ACTION]                TINYINT         NOT NULL,
    [OLDVALUE]              NVARCHAR (4000) NULL,
    [NEWVALUE]              NVARCHAR (4000) NULL,
    [VALIDATION]            NVARCHAR (4000) NULL,
    [KEY_FinPromRegisterId] INT             NOT NULL,
    [KEY_FinPromEventType]  VARCHAR (128)   NOT NULL,
    [KEY_EventDate]         DATETIME        NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT15] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT15]([INSERTED] ASC);

