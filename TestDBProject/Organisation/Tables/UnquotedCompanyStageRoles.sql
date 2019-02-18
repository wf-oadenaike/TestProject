CREATE TABLE [Organisation].[UnquotedCompanyStageRoles] (
    [UnquotedCompanyStage]      VARCHAR (5)   NOT NULL,
    [RoleId]                    SMALLINT      NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_UCSR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_UCSR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_UCSR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_UCSR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_UCSR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKUnquotedCompanyStageRoles] PRIMARY KEY CLUSTERED ([UnquotedCompanyStage] ASC, [RoleId] ASC),
    CONSTRAINT [UnquotedCompanyStageRolesRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [UnquotedCompanyStageRolesUnquotedCompanyStage] FOREIGN KEY ([UnquotedCompanyStage]) REFERENCES [Organisation].[UnquotedCompanyStages] ([UnquotedCompanyStage])
);

