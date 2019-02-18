CREATE TABLE [Organisation].[UnquotedCompanyCompletionChecklist] (
    [UnquotedCompanyId]             INT           NOT NULL,
    [ComplianceChecksComplete]      BIT           NOT NULL,
    [InvestmentTrustBoardReporting] BIT           NOT NULL,
    [InitialInvestmentDate]         DATETIME      NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME      CONSTRAINT [DF_UCCC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME      CONSTRAINT [DF_UCCC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50) CONSTRAINT [DF_UCCC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT           CONSTRAINT [DF_UCCC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME      CONSTRAINT [DF_UCCC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKUnquotedCompanyCompletionChecklist] PRIMARY KEY CLUSTERED ([UnquotedCompanyId] ASC),
    CONSTRAINT [UnquotedCompanyCompletionChecklistUnquotedCompanyId] FOREIGN KEY ([UnquotedCompanyId]) REFERENCES [Organisation].[UnquotedCompanies] ([UnquotedCompanyId])
);

