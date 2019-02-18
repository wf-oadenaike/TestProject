CREATE TABLE [Investment].[ICAAPRegister] (
    [ICAAPRegisterId]                   INT              IDENTITY (1, 1) NOT NULL,
    [SubmittedByPersonId]               SMALLINT         NOT NULL,
    [FinancialYear]                     VARCHAR (25)     NOT NULL,
    [ICAAPSubmittedDate]                DATE             NOT NULL,
    [RiskBasedICAAPAmount]              DECIMAL (19, 2)  NULL,
    [ICAAPAmount]                       DECIMAL (19, 2)  NULL,
    [DocumentationFolderLink]           VARCHAR (2000)   NULL,
    [JoinGUID]                          UNIQUEIDENTIFIER NOT NULL,
    [ICAAPRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_IR_IRCDT] DEFAULT (getdate()) NOT NULL,
    [ICAAPRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_IR_IRLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKICAAPRegister] PRIMARY KEY CLUSTERED ([ICAAPRegisterId] ASC),
    CONSTRAINT [ICAAPRegisterSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIICAAPRegister]
    ON [Investment].[ICAAPRegister]([FinancialYear] ASC);

