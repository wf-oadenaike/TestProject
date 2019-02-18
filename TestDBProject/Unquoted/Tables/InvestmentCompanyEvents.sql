CREATE TABLE [Unquoted].[InvestmentCompanyEvents] (
    [CompanyEventId]         INT           IDENTITY (1, 1) NOT NULL,
    [CompanyId]              INT           NULL,
    [SubmittedByPersonId]    SMALLINT      NULL,
    [EventDetails]           VARCHAR (500) NULL,
    [EventDateTime]          DATETIME      NULL,
    [Description]            VARCHAR (500) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF_ICEV_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF_ICEV_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF_ICEV_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKInvestmentCompanyEvents] PRIMARY KEY CLUSTERED ([CompanyEventId] ASC),
    CONSTRAINT [CompanyEventsPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [InvestmentCompanyEventsCompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Unquoted].[InvestmentCompanies] ([CompanyId])
);

