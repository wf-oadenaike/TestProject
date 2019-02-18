CREATE TABLE [Finance].[TransactionTypes] (
    [TransactionTypeId]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [TransactionTypeBK]          CHAR (2)      NOT NULL,
    [TransactionTypeName]        [sysname]     NOT NULL,
    [TransactionTypeDescription] VARCHAR (255) NULL,
    [ControlId]                  BIGINT        NOT NULL,
    [QwdTransactionType]         VARCHAR (50)  NULL,
    CONSTRAINT [XPKTransactionTypes] PRIMARY KEY CLUSTERED ([TransactionTypeId] ASC),
    CONSTRAINT [TransactionTypeUniqueTransactionTypeBK] UNIQUE NONCLUSTERED ([TransactionTypeBK] ASC)
);

