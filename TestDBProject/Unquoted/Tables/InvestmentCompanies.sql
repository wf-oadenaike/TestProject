CREATE TABLE [Unquoted].[InvestmentCompanies] (
    [CompanyId]                 INT           IDENTITY (1, 1) NOT NULL,
    [SFID]                      VARCHAR (300) NULL,
    [StatusId]                  INT           NULL,
    [CompanyName]               VARCHAR (100) NULL,
    [ReferrerName]              VARCHAR (100) NULL,
    [StageId]                   INT           NULL,
    [ReferrerContactId]         VARCHAR (18)  NULL,
    [SystemStatusId]            INT           NULL,
    [InvestmentAnalystPersonId] SMALLINT      NULL,
    [InvestmentOwnerPersonId]   SMALLINT      NULL,
    [BoxDocumentLocation]       VARCHAR (300) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_IC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_IC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_IC_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKInvestmentCompanies] PRIMARY KEY CLUSTERED ([CompanyId] ASC),
    CONSTRAINT [InvestmentCompaniesInvestmentAnalystPersonId] FOREIGN KEY ([InvestmentAnalystPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [InvestmentCompaniesInvestmentOwnerPersonId] FOREIGN KEY ([InvestmentOwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [InvestmentCompaniesStageId] FOREIGN KEY ([StageId]) REFERENCES [Unquoted].[Stages] ([StageId]),
    CONSTRAINT [InvestmentCompaniesStatusId] FOREIGN KEY ([StatusId]) REFERENCES [Unquoted].[Status] ([StatusId])
);

