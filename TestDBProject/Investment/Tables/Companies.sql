﻿CREATE TABLE [Investment].[Companies] (
    [CompanyId]                              INT              IDENTITY (1, 1) NOT NULL,
    [CompanyName]                            NVARCHAR (256)   NOT NULL,
    [CompanySalesforceId]                    VARCHAR (18)     NULL,
    [PrimaryContactSalesforceId]             VARCHAR (18)     NULL,
    [InvestmentAnalystPersonId]              SMALLINT         NULL,
    [InvestmentManagerOwnerPersonId]         SMALLINT         NULL,
    [CurrentUnquotedCompanyStage]            VARCHAR (5)      NULL,
    [NextReviewDate]                         DATETIME         NULL,
    [CompanyOverview]                        VARCHAR (MAX)    NULL,
    [NotesForSalesTeam]                      VARCHAR (MAX)    NULL,
    [CurrentPrice]                           DECIMAL (19, 2)  NULL,
    [CurrencyCode]                           CHAR (3)         NULL,
    [CompanyRootFolderURL]                   VARCHAR (2000)   NULL,
    [InitialInformationFolderURL]            VARCHAR (2000)   NULL,
    [InitialInvestmentRulesAssessment]       BIT              NULL,
    [SectorId]                               INT              NULL,
    [SubSectorId]                            INT              NULL,
    [CountryISOCode]                         CHAR (2)         NULL,
    [WIMEIFCompanyMaturityId]                INT              NULL,
    [WIMPCTCompanyMaturityId]                INT              NULL,
    [InvestmentDate]                         DATE             NULL,
    [NAVatInvestment]                        DECIMAL (10, 6)  NULL,
    [JiraEpicKey]                            VARCHAR (32)     NULL,
    [JiraIssueKey]                           VARCHAR (32)     NULL,
    [ComplianceChecksComplete]               BIT              NULL,
    [InvestmentTrustBoardReporting]          BIT              NULL,
    [IsQuotedCompany]                        BIT              CONSTRAINT [DF_CO_IQC] DEFAULT ((1)) NOT NULL,
    [DevelopmentClassificationId]            INT              NULL,
    [PrimaryRelationInvestmentSourceId]      INT              NULL,
    [SecondaryRelationEstEvergreenVentureId] INT              NULL,
    [IsFCARegulated]                         BIT              NULL,
    [IsSRARegulated]                         BIT              NULL,
    [JoinGUID]                               UNIQUEIDENTIFIER NULL,
    [CompaniesCreationDate]                  DATETIME         CONSTRAINT [DF_CO_COCDT] DEFAULT (getdate()) NOT NULL,
    [CompaniesLastModifiedDate]              DATETIME         CONSTRAINT [DF_CO_COLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME         CONSTRAINT [DF_CO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME         CONSTRAINT [DF_CO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50)    CONSTRAINT [DF_CO_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                  INT              CONSTRAINT [DF_CO_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                 ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]              DATETIME         CONSTRAINT [DF_CO_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKCompanies] PRIMARY KEY CLUSTERED ([CompanyId] ASC),
    CONSTRAINT [CompaniesCountryISOCode] FOREIGN KEY ([CountryISOCode]) REFERENCES [Core].[Countries] ([ISOCode]),
    CONSTRAINT [CompaniesDevelopmentClassificationId] FOREIGN KEY ([DevelopmentClassificationId]) REFERENCES [Investment].[DevelopmentStages] ([Id]),
    CONSTRAINT [CompaniesInvestmentAnalystPersonId] FOREIGN KEY ([InvestmentAnalystPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [CompaniesInvestmentManagerOwnerPersonId] FOREIGN KEY ([InvestmentManagerOwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [CompaniesPrimaryRelationInvestmentSourceId] FOREIGN KEY ([PrimaryRelationInvestmentSourceId]) REFERENCES [Investment].[InvestmentSources] ([Id]),
    CONSTRAINT [CompaniesSecondaryRelationEstEvergreenVentureId] FOREIGN KEY ([SecondaryRelationEstEvergreenVentureId]) REFERENCES [Investment].[EstablishedEvergreenVentures] ([Id]),
    CONSTRAINT [CompaniesSectorId] FOREIGN KEY ([SectorId]) REFERENCES [Core].[Sectors] ([SectorId]),
    CONSTRAINT [CompaniesSubSectorId] FOREIGN KEY ([SubSectorId]) REFERENCES [Core].[Sectors] ([SectorId]),
    CONSTRAINT [CompaniesUnquotedCompanyStage] FOREIGN KEY ([CurrentUnquotedCompanyStage]) REFERENCES [Organisation].[UnquotedCompanyStages] ([UnquotedCompanyStage]),
    CONSTRAINT [CompaniesWIMEIFCompanyMaturityId] FOREIGN KEY ([WIMEIFCompanyMaturityId]) REFERENCES [Core].[CompanyMaturities] ([CompanyMaturityId]),
    CONSTRAINT [CompaniesWIMPCTCompanyMaturityId] FOREIGN KEY ([WIMPCTCompanyMaturityId]) REFERENCES [Core].[CompanyMaturities] ([CompanyMaturityId])
);

