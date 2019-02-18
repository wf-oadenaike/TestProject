CREATE TABLE [Organisation].[AnnualBudgetReviews] (
    [AnnualBudgetReviewId]       INT              IDENTITY (1, 1) NOT NULL,
    [AnnualBudgetId]             INT              NOT NULL,
    [ReviewTypeId]               INT              NOT NULL,
    [ReviewComments]             VARCHAR (MAX)    NOT NULL,
    [ReviewDate]                 DATETIME         NOT NULL,
    [BudgetApproved]             BIT              NULL,
    [ReviewedByPersonId]         SMALLINT         NOT NULL,
    [DocumentationFolderLink]    VARCHAR (2000)   NULL,
    [JoinGUID]                   UNIQUEIDENTIFIER NOT NULL,
    [ReviewCreationDatetime]     DATETIME         CONSTRAINT [DF_ABR_CDT] DEFAULT (getdate()) NOT NULL,
    [ReviewLastModifiedDatetime] DATETIME         CONSTRAINT [DF_ABR_LMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME         CONSTRAINT [DF_ABR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME         CONSTRAINT [DF_ABR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)    CONSTRAINT [DF_ABR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]      INT              CONSTRAINT [DF_ABR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]     ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]  DATETIME         CONSTRAINT [DF_ABR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKAnnualBudgetReview] PRIMARY KEY CLUSTERED ([AnnualBudgetReviewId] ASC),
    CONSTRAINT [AnnualBudgetId] FOREIGN KEY ([AnnualBudgetId]) REFERENCES [Organisation].[AnnualBudget] ([AnnualBudgetId]),
    CONSTRAINT [AnnualBudgetReviewReviewedByPersonId] FOREIGN KEY ([ReviewedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [AnnualBudgetReviewTypeId] FOREIGN KEY ([ReviewTypeId]) REFERENCES [Organisation].[AnnualBudgetReviewTypes] ([ReviewTypeId])
);

