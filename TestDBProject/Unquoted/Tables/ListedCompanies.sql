CREATE TABLE [Unquoted].[ListedCompanies] (
    [ListedCompanyId]                        INT            IDENTITY (1, 1) NOT NULL,
    [ListedCompanyName]                      NVARCHAR (256) NOT NULL,
    [InvestmentAnalystPersonId]              SMALLINT       NULL,
    [InvestmentManagerOwnerPersonId]         SMALLINT       NULL,
    [SectorId]                               INT            NULL,
    [SubSectorId]                            INT            NULL,
    [WIMEIFCompanyMaturityId]                INT            CONSTRAINT [DF_LC_ECMI] DEFAULT ((-1)) NOT NULL,
    [WIMPCTCompanyMaturityId]                INT            CONSTRAINT [DF_LC_PCMI] DEFAULT ((-1)) NOT NULL,
    [DevelopmentClassification]              VARCHAR (255)  NULL,
    [DevelopmentClassificationId]            INT            NULL,
    [PrimaryRelationInvestmentSource]        INT            NULL,
    [SecondaryRelationEstEvergreenVentureId] INT            NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME       CONSTRAINT [DF_LC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME       CONSTRAINT [DF_LC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50)  CONSTRAINT [DF_LC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                  INT            CONSTRAINT [DF_LC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                 ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]              DATETIME       CONSTRAINT [DF_LC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKListedCompanies] PRIMARY KEY CLUSTERED ([ListedCompanyId] ASC),
    CONSTRAINT [ListedCompaniesInvestmentAnalystPersonId] FOREIGN KEY ([InvestmentAnalystPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ListedCompaniesInvestmentManagerOwnerPersonId] FOREIGN KEY ([InvestmentManagerOwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ListedCompaniesSectorId] FOREIGN KEY ([SectorId]) REFERENCES [Core].[Sectors] ([SectorId]),
    CONSTRAINT [ListedCompaniesSubSectorId] FOREIGN KEY ([SubSectorId]) REFERENCES [Core].[Sectors] ([SectorId]),
    CONSTRAINT [ListedCompaniesWIMEIFCompanyMaturityId] FOREIGN KEY ([WIMEIFCompanyMaturityId]) REFERENCES [Core].[CompanyMaturities] ([CompanyMaturityId]),
    CONSTRAINT [ListedCompaniesWIMPCTCompanyMaturityId] FOREIGN KEY ([WIMPCTCompanyMaturityId]) REFERENCES [Core].[CompanyMaturities] ([CompanyMaturityId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_ListedCompanies_CompanyName]
    ON [Unquoted].[ListedCompanies]([ListedCompanyName] ASC);

