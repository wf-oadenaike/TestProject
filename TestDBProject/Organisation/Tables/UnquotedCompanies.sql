﻿CREATE TABLE [Organisation].[UnquotedCompanies] (
    [UnquotedCompanyId]                 INT              IDENTITY (1, 1) NOT NULL,
    [UnquotedCompanyName]               NVARCHAR (256)   NOT NULL,
    [UnquotedCompanySalesforceId]       VARCHAR (18)     NOT NULL,
    [PrimaryContactSalesforceId]        VARCHAR (18)     NULL,
    [InvestmentAnalystPersonId]         SMALLINT         NULL,
    [InvestmentManagerOwnerPersonId]    SMALLINT         NOT NULL,
    [InvestmentManagerOwnerRoleId]      SMALLINT         NOT NULL,
    [CurrentUnquotedCompanyStage]       VARCHAR (5)      NOT NULL,
    [InitialMeetingDate]                DATETIME         NULL,
    [Attendees]                         VARCHAR (MAX)    NULL,
    [NextReviewDate]                    DATETIME         NULL,
    [CompanyOverview]                   VARCHAR (MAX)    NULL,
    [NotesForSalesTeam]                 VARCHAR (MAX)    NULL,
    [CurrentPrice]                      DECIMAL (19, 2)  NULL,
    [CurrencyCode]                      CHAR (3)         NULL,
    [UnquotedCompanyRootFolderURL]      VARCHAR (2000)   NULL,
    [InitialInformationFolderURL]       VARCHAR (2000)   NULL,
    [InitialDueDiligenceFolderURL]      VARCHAR (2000)   NULL,
    [FinalInvestmentFolderURL]          VARCHAR (2000)   NULL,
    [InitialInvestmentRulesAssessment]  BIT              NOT NULL,
    [JiraEpicKey]                       VARCHAR (32)     NULL,
    [JiraIssueKey]                      VARCHAR (32)     NULL,
    [IsFCARegulated]                    BIT              NULL,
    [IsSRARegulated]                    BIT              NULL,
    [WorkflowVersionGUID]               UNIQUEIDENTIFIER NULL,
    [JoinGUID]                          UNIQUEIDENTIFIER NOT NULL,
    [UnquotedCompaniesCreationDate]     DATETIME         CONSTRAINT [DF_UC_UCCDT] DEFAULT (getdate()) NOT NULL,
    [UnquotedCompaniesLastModifiedDate] DATETIME         CONSTRAINT [DF_UC_UCLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]             DATETIME         CONSTRAINT [DF_UC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]              DATETIME         CONSTRAINT [DF_UC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]            NVARCHAR (50)    CONSTRAINT [DF_UC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]             INT              CONSTRAINT [DF_UC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]            ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]         DATETIME         CONSTRAINT [DF_UC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKUnquotedCompanies] PRIMARY KEY CLUSTERED ([UnquotedCompanyId] ASC),
    CONSTRAINT [UnquotedCompaniesInvestmentAnalystPersonId] FOREIGN KEY ([InvestmentAnalystPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [UnquotedCompaniesInvestmentManagerOwnerPersonId] FOREIGN KEY ([InvestmentManagerOwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [UnquotedCompaniesInvestmentManagerOwnerRoleId] FOREIGN KEY ([InvestmentManagerOwnerRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [UnquotedCompaniesUnquotedCompanyStage] FOREIGN KEY ([CurrentUnquotedCompanyStage]) REFERENCES [Organisation].[UnquotedCompanyStages] ([UnquotedCompanyStage])
);

