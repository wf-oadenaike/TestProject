CREATE TABLE [Sales].[ClientPricingApproval] (
    [ClientPricingApprovalId]        INT              IDENTITY (1, 1) NOT NULL,
    [MyApprovalsId]                  INT              NOT NULL,
    [ClientName]                     VARCHAR (255)    NOT NULL,
    [InvestmentType]                 VARCHAR (255)    NOT NULL,
    [InitialInvestment]              VARCHAR (255)    NOT NULL,
    [PotentialInvestment]            VARCHAR (255)    NOT NULL,
    [TimelineForPotentialInvestment] VARCHAR (255)    NOT NULL,
    [ShareclassOffering]             VARCHAR (255)    NULL,
    [RebateOffering]                 VARCHAR (255)    NULL,
    [SegregatedFeeProposalDetails]   VARCHAR (255)    NULL,
    [SubmittedByPersonId]            SMALLINT         CONSTRAINT [DF_CPA_CPASP] DEFAULT ((-1)) NOT NULL,
    [DocumentationFolderLink]        VARCHAR (2000)   NOT NULL,
    [JoinGUID]                       UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME         CONSTRAINT [DF_CPA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME         CONSTRAINT [DF_CPA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)    CONSTRAINT [DF_CPA_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]          INT              CONSTRAINT [DF_CPA_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]         ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]      DATETIME         CONSTRAINT [DF_CPA_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ClientPricingApprovalId] PRIMARY KEY CLUSTERED ([ClientPricingApprovalId] ASC),
    CONSTRAINT [ClientPricingApprovalSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

