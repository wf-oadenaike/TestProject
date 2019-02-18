CREATE TABLE [Risk].[RMFReview] (
    [RMFReviewId]                   INT              IDENTITY (1, 1) NOT NULL,
    [SubCategoryId]                 SMALLINT         NOT NULL,
    [RMFStatus]                     VARCHAR (128)    NOT NULL,
    [RMFStatusRationale]            VARCHAR (MAX)    NULL,
    [ManagementActivities]          VARCHAR (MAX)    NULL,
    [SubmittedByPersonId]           SMALLINT         CONSTRAINT [DF_RMFR_SP] DEFAULT ((-1)) NOT NULL,
    [SubmittedDate]                 DATETIME         CONSTRAINT [DF_RMFR_SD] DEFAULT (getdate()) NOT NULL,
    [IsActive]                      BIT              CONSTRAINT [DF_RMFR_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [RMFReviewCreationDatetime]     DATETIME         CONSTRAINT [DF_RMFR_RMFRCDT] DEFAULT (getdate()) NOT NULL,
    [RMFReviewLastModifiedDatetime] DATETIME         CONSTRAINT [DF_RMFR_RMFRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_RMFR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_RMFR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_RMFR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_RMFR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_RMFR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRMFReview] PRIMARY KEY CLUSTERED ([RMFReviewId] ASC),
    CONSTRAINT [RMFReviewSubCategoryId] FOREIGN KEY ([SubCategoryId]) REFERENCES [Risk].[SubCategories] ([SubCategoryId]),
    CONSTRAINT [RMFReviewSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

