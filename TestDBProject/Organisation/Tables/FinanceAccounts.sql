CREATE TABLE [Organisation].[FinanceAccounts] (
    [FinanceAccountId] INT            IDENTITY (1, 1) NOT NULL,
    [NominalCode]      INT            NOT NULL,
    [AccountName]      NVARCHAR (128) NOT NULL,
    [CategoryName]     NVARCHAR (128) NULL,
    CONSTRAINT [PKFinanceAccounts] PRIMARY KEY NONCLUSTERED ([FinanceAccountId] ASC)
);


GO
CREATE UNIQUE CLUSTERED INDEX [UXIFinanceAccounts]
    ON [Organisation].[FinanceAccounts]([NominalCode] ASC, [AccountName] ASC);

