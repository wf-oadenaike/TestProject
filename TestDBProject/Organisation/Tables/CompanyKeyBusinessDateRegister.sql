CREATE TABLE [Organisation].[CompanyKeyBusinessDateRegister] (
    [CompanyKeyBusinessDateId]                           INT              IDENTITY (1, 1) NOT NULL,
    [BusinessActivity]                                   NVARCHAR (128)   NOT NULL,
    [BusinessActivityTypeId]                             SMALLINT         NOT NULL,
    [FinancialYearReference]                             VARCHAR (50)     NULL,
    [ReporterRoleId]                                     SMALLINT         NULL,
    [AssigneeRoleId]                                     SMALLINT         NULL,
    [DocumentationFolderLink]                            VARCHAR (2000)   NULL,
    [JoinGUID]                                           UNIQUEIDENTIFIER NOT NULL,
    [CompanyKeyBusinessDateRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_CKBDR_CKBDRCDT] DEFAULT (getdate()) NOT NULL,
    [CompanyKeyBusinessDateRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CKBDR_CKBDRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                              DATETIME         CONSTRAINT [DF_CKBDR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                               DATETIME         CONSTRAINT [DF_CKBDR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                             NVARCHAR (50)    CONSTRAINT [DF_CKBDR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                              INT              CONSTRAINT [DF_CKBDR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                             ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                          DATETIME         CONSTRAINT [DF_CKBDR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKCompanyKeyBusinessDateRegister] PRIMARY KEY CLUSTERED ([CompanyKeyBusinessDateId] ASC),
    CONSTRAINT [CompanyKeyBusinessDateRegisterAssigneeRoleId] FOREIGN KEY ([AssigneeRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [CompanyKeyBusinessDateRegisterBusinessActivityTypeId] FOREIGN KEY ([BusinessActivityTypeId]) REFERENCES [Organisation].[CompanyBusinessActivityTypes] ([BusinessActivityTypeId]),
    CONSTRAINT [CompanyKeyBusinessDateRegisterReporterRoleId] FOREIGN KEY ([ReporterRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXICompanyKeyBusinessDateRegister]
    ON [Organisation].[CompanyKeyBusinessDateRegister]([BusinessActivity] ASC);

