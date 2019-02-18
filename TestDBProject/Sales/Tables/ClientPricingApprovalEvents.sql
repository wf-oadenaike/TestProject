CREATE TABLE [Sales].[ClientPricingApprovalEvents] (
    [ClientPricingApprovalEventId] INT              IDENTITY (1, 1) NOT NULL,
    [ClientPricingApprovalId]      INT              NOT NULL,
    [EventDetails]                 VARCHAR (MAX)    NOT NULL,
    [SubmittedByPersonId]          SMALLINT         NOT NULL,
    [DocumentationFolderLink]      NVARCHAR (2000)  NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]        DATETIME         CONSTRAINT [DF_CPAE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]         DATETIME         CONSTRAINT [DF_CPAE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]       NVARCHAR (50)    CONSTRAINT [DF_CPAE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]        INT              CONSTRAINT [DF_CPAE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]       ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]    DATETIME         CONSTRAINT [DF_CPAE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKClientPricingApprovalEventId] PRIMARY KEY CLUSTERED ([ClientPricingApprovalEventId] ASC),
    CONSTRAINT [ClientPricingApprovalEventsClientPricingApprovalId] FOREIGN KEY ([ClientPricingApprovalId]) REFERENCES [Sales].[ClientPricingApproval] ([ClientPricingApprovalId]),
    CONSTRAINT [ClientPricingApprovalEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

