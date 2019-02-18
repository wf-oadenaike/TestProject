CREATE TABLE [CADIS_PROC].[DG_FUNCTION_AUDIT37] (
    [ID]                      INT             IDENTITY (1, 1) NOT NULL,
    [IDENTIFIER]              INT             NOT NULL,
    [INSERTED]                DATETIME        NOT NULL,
    [CHANGEDBY]               NVARCHAR (256)  NOT NULL,
    [FIELDNAME]               NVARCHAR (200)  NOT NULL,
    [ACTION]                  TINYINT         NOT NULL,
    [OLDVALUE]                NVARCHAR (4000) NULL,
    [NEWVALUE]                NVARCHAR (4000) NULL,
    [VALIDATION]              NVARCHAR (4000) NULL,
    [KEY_DepartmentId]        SMALLINT        NOT NULL,
    [KEY_PostingDateId]       INT             NOT NULL,
    [KEY_TransactionDateId]   INT             NOT NULL,
    [KEY_FinancialLineTypeId] SMALLINT        NOT NULL,
    [KEY_NominalCode]         INT             NOT NULL,
    [KEY_TransactionNo]       INT             NOT NULL,
    [KEY_CurrentRow]          BIT             NOT NULL,
    [KEY_CurrentRowSwitchId]  BIGINT          NOT NULL,
    [KEY_DeletedRow]          BIT             NOT NULL,
    CONSTRAINT [PK_DG_FUNCTION_AUDIT37] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDXAUDITDATE]
    ON [CADIS_PROC].[DG_FUNCTION_AUDIT37]([INSERTED] ASC);

