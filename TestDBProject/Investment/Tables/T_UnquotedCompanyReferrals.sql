CREATE TABLE [Investment].[T_UnquotedCompanyReferrals] (
    [ID]                        INT            IDENTITY (1, 1) NOT NULL,
    [Name]                      VARCHAR (100)  NULL,
    [SubsectorID]               SMALLINT       NULL,
    [StatusID]                  SMALLINT       NULL,
    [Description]               VARCHAR (1000) NULL,
    [InternalNotes]             VARCHAR (1000) NULL,
    [SFAccountID]               VARCHAR (18)   NULL,
    [ReferrerSFContactID]       VARCHAR (18)   NULL,
    [BoxFolderID]               VARCHAR (15)   NULL,
    [SubmittedBy]               VARCHAR (100)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  DEFAULT ('UNKNOWN') NULL,
    [CountryID]                 INT            NULL,
    [InvestmentAnalystPersonID] INT            NULL,
    [FundManagerPersonID]       INT            NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_UnquotedCompanyReferralSubsectorID] FOREIGN KEY ([SubsectorID]) REFERENCES [Investment].[T_REF_ICBSubsectors] ([ID])
);

