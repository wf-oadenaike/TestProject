CREATE TABLE [Organisation].[ValuationReviews] (
    [ValuationReviewId]                     INT              IDENTITY (1, 1) NOT NULL,
    [UnquotedCompanyId]                     INT              NOT NULL,
    [ValuationReviewMeetingDate]            DATETIME         NOT NULL,
    [BoxUrl]                                NVARCHAR (2000)  NULL,
    [WorkflowVersionGUID]                   UNIQUEIDENTIFIER NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [ValuationReviewCreationDate]           DATETIME         CONSTRAINT [DF_VR_VRCD] DEFAULT (getdate()) NOT NULL,
    [ValuationReviewCreatedByPersonId]      SMALLINT         NOT NULL,
    [ValuationReviewModifiedDate]           DATETIME         CONSTRAINT [DF_VR_VRLMD] DEFAULT (getdate()) NOT NULL,
    [ValuationReviewLastModifiedByPersonId] SMALLINT         NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME         CONSTRAINT [DF_VR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME         CONSTRAINT [DF_VR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)    CONSTRAINT [DF_VR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT              CONSTRAINT [DF_UVR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME         CONSTRAINT [DF_VR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKValuationReview] PRIMARY KEY CLUSTERED ([ValuationReviewId] ASC),
    CONSTRAINT [ValuationReviewsUnquotedCompanyId] FOREIGN KEY ([UnquotedCompanyId]) REFERENCES [Organisation].[UnquotedCompanies] ([UnquotedCompanyId])
);

