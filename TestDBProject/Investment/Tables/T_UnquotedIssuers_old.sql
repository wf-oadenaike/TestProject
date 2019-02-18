CREATE TABLE [Investment].[T_UnquotedIssuers_old] (
    [ID]                        INT           IDENTITY (1, 1) NOT NULL,
    [LegalName]                 VARCHAR (255) NULL,
    [CountryID]                 INT           NULL,
    [CurrencyID]                SMALLINT      NULL,
    [SubsectorID]               SMALLINT      NULL,
    [SFAccountID]               VARCHAR (18)  NULL,
    [BoxFolderID]               VARCHAR (18)  NULL,
    [JiraEpicKey]               VARCHAR (18)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [IsActive]                  BIT           CONSTRAINT [df_IsActive] DEFAULT ('0') NULL,
    [FundManagerPersonID]       SMALLINT      NULL,
    [InvestmentAnalystPersonID] SMALLINT      NULL,
    [CompanyNumber]             VARCHAR (255) NULL,
    [CompanyType]               VARCHAR (255) NULL,
    [KnownName]                 VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_UnquotedIssuerSubsector] FOREIGN KEY ([SubsectorID]) REFERENCES [Investment].[T_REF_ICBSubsectors] ([ID]),
    CONSTRAINT [FK_UnquoteIssuerFundManagerID] FOREIGN KEY ([FundManagerPersonID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [FK_UnquoteIssuerInvestmentAnalystID] FOREIGN KEY ([InvestmentAnalystPersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

