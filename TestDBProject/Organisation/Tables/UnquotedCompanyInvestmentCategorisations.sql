CREATE TABLE [Organisation].[UnquotedCompanyInvestmentCategorisations] (
    [UnquotedCompanyId]                              INT              NOT NULL,
    [InvestmentCategorisationMeetingDate]            DATETIME         NOT NULL,
    [InvestmentCategory]                             SMALLINT         NOT NULL,
    [AnnualConfluenceChecklistUrl]                   NVARCHAR (2000)  NULL,
    [WorkflowVersionGUID]                            UNIQUEIDENTIFIER NULL,
    [JoinGUID]                                       UNIQUEIDENTIFIER NOT NULL,
    [InvestmentCategorisationCreationDate]           DATETIME         CONSTRAINT [DF_UCIC_ICCDT] DEFAULT (getdate()) NOT NULL,
    [InvestmentCategorisationCreatedByPersonId]      SMALLINT         NOT NULL,
    [InvestmentCategorisationModifiedDate]           DATETIME         CONSTRAINT [DF_UCIC_ICLMDT] DEFAULT (getdate()) NOT NULL,
    [InvestmentCategorisationLastModifiedByPersonId] SMALLINT         NOT NULL,
    [CADIS_SYSTEM_INSERTED]                          DATETIME         CONSTRAINT [DF_UCIC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                           DATETIME         CONSTRAINT [DF_UCIC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                         NVARCHAR (50)    CONSTRAINT [DF_UCIC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                          INT              CONSTRAINT [DF_UCIC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                         ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                      DATETIME         CONSTRAINT [DF_UCIC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKInvestmentCategorisation] PRIMARY KEY CLUSTERED ([UnquotedCompanyId] ASC),
    CONSTRAINT [UnquotedCompanyInvestmentCategorisationsUnquotedCompanyId] FOREIGN KEY ([UnquotedCompanyId]) REFERENCES [Organisation].[UnquotedCompanies] ([UnquotedCompanyId])
);

