CREATE TABLE [Organisation].[UnquotedCompanyCommentaries] (
    [UnquotedCompanyCommentaryId] INT              IDENTITY (1, 1) NOT NULL,
    [UnquotedCompanyStage]        VARCHAR (5)      NOT NULL,
    [UnquotedCompanyId]           INT              NOT NULL,
    [Commentary]                  NVARCHAR (MAX)   NOT NULL,
    [CommentaryByPersonId]        SMALLINT         NOT NULL,
    [CommentaryByRoleId]          SMALLINT         NOT NULL,
    [CommentaryCreatedDate]       DATETIME         CONSTRAINT [DF_UCC_CCDT] DEFAULT (getdate()) NOT NULL,
    [CommentaryLastModifiedDate]  DATETIME         CONSTRAINT [DF_UCC_CCLMD] DEFAULT (getdate()) NOT NULL,
    [JoinGUID]                    UNIQUEIDENTIFIER NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME         CONSTRAINT [DF_UCC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME         CONSTRAINT [DF_UCC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)    CONSTRAINT [DF_UCC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]       INT              CONSTRAINT [DF_UCC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]      ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]   DATETIME         CONSTRAINT [DF_UCC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKUnquotedCompanyCommentaries] PRIMARY KEY CLUSTERED ([UnquotedCompanyCommentaryId] ASC),
    CONSTRAINT [UnquotedCompanyCommentariesCommentaryByPersonId] FOREIGN KEY ([CommentaryByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [UnquotedCompanyCommentariesCommentaryByRoleId] FOREIGN KEY ([CommentaryByRoleId]) REFERENCES [Core].[Roles] ([RoleId]),
    CONSTRAINT [UnquotedCompanyCommentariesUnquotedCompanyId] FOREIGN KEY ([UnquotedCompanyId]) REFERENCES [Organisation].[UnquotedCompanies] ([UnquotedCompanyId]),
    CONSTRAINT [UnquotedCompanyCommentariesUnquotedCompanyStageDecisionByRoleName] FOREIGN KEY ([UnquotedCompanyStage], [CommentaryByRoleId]) REFERENCES [Organisation].[UnquotedCompanyStageRoles] ([UnquotedCompanyStage], [RoleId]),
    CONSTRAINT [UnquotedCompanyCommentariesUnquotedCompanyStageId] FOREIGN KEY ([UnquotedCompanyStage]) REFERENCES [Organisation].[UnquotedCompanyStages] ([UnquotedCompanyStage])
);

