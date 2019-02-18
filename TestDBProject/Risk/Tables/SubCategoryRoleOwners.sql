CREATE TABLE [Risk].[SubCategoryRoleOwners] (
    [SubCategoryId]             SMALLINT      NOT NULL,
    [RoleId]                    SMALLINT      NOT NULL,
    [CreatedDate]               DATETIME      CONSTRAINT [DT_SCRO_CD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_SCRO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_SCRO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_SCRO_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_SCRO_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_SCRO_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKSubCategoryRoleOwners] PRIMARY KEY CLUSTERED ([SubCategoryId] ASC, [RoleId] ASC),
    CONSTRAINT [SubCategoryRoleOwnersCategoryId] FOREIGN KEY ([SubCategoryId]) REFERENCES [Risk].[SubCategories] ([SubCategoryId]),
    CONSTRAINT [SubCategoryRoleOwnersRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

