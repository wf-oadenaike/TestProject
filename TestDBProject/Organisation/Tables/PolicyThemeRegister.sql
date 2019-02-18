CREATE TABLE [Organisation].[PolicyThemeRegister] (
    [PolicyThemeRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [PTPCategoryId]                   SMALLINT         NOT NULL,
    [PolicyThemeNameBK]               [sysname]        NOT NULL,
    [PolicyThemeVersionNo]            REAL             NOT NULL,
    [PolicyThemeExpiryDate]           DATE             NULL,
    [PolicyThemeDocumentStatus]       [sysname]        NOT NULL,
    [ActiveFlag]                      BIT              CONSTRAINT [DF_PTR_AF] DEFAULT ((1)) NULL,
    [ChangeStatus]                    [sysname]        NULL,
    [ChangeReason]                    [sysname]        NULL,
    [PolicyThemeSummary]              VARCHAR (2048)   NOT NULL,
    [PolicyThemeReviewFrequencyId]    INT              CONSTRAINT [DF_PTR_PFRF] DEFAULT ((1)) NOT NULL,
    [DocumentationFolderLink]         VARCHAR (2000)   NULL,
    [DocumentationFolderId]           INT              NULL,
    [WorkflowVersionGUID]             UNIQUEIDENTIFIER NULL,
    [JoinGUID]                        UNIQUEIDENTIFIER NOT NULL,
    [PolicyThemeCreationDatetime]     DATETIME         CONSTRAINT [DF_PTR_PTCDT] DEFAULT (getdate()) NOT NULL,
    [PolicyThemeLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PTR_PTLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKPolicyThemeRegister] PRIMARY KEY CLUSTERED ([PolicyThemeNameBK] ASC),
    CONSTRAINT [PolicyThemeRegisterPolicyThemeReviewFrequencyId ] FOREIGN KEY ([PolicyThemeReviewFrequencyId]) REFERENCES [Organisation].[PolicyThemeReviewFrequencies] ([PolicyThemeReviewFrequencyId]),
    CONSTRAINT [PolicyThemeRegisterPTPCategoryId] FOREIGN KEY ([PTPCategoryId]) REFERENCES [Organisation].[PolicyThemeProcedureCategories] ([PTPCategoryId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIXPolicyThemeRegisterIdBK]
    ON [Organisation].[PolicyThemeRegister]([PolicyThemeRegisterId] ASC);

