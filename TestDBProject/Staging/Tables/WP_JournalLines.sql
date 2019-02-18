CREATE TABLE [Staging].[WP_JournalLines] (
    [JournalID]      VARCHAR (50)  NULL,
    [JournalNumber]  INT           NULL,
    [JournalDate]    DATE          NULL,
    [Reference]      VARCHAR (MAX) NULL,
    [JournalLineID]  VARCHAR (50)  NULL,
    [SourceType]     VARCHAR (50)  NULL,
    [SourceId]       VARCHAR (50)  NULL,
    [AccountID]      VARCHAR (50)  NULL,
    [AccountCode]    INT           NULL,
    [AccountType]    VARCHAR (50)  NULL,
    [AccountName]    VARCHAR (MAX) NULL,
    [Description]    VARCHAR (MAX) NULL,
    [NetAmount]      MONEY         NULL,
    [GrossAmount]    MONEY         NULL,
    [TaxAmount]      MONEY         NULL,
    [TaxType]        VARCHAR (50)  NULL,
    [TaxName]        VARCHAR (50)  NULL,
    [Organisational] VARCHAR (50)  NULL,
    [Projects]       VARCHAR (MAX) NULL
);

