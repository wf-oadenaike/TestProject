CREATE TABLE [Organisation].[PolicyThemeProcedureRoleRelationship] (
    [PolicyThemeProcedureId]                   INT      NOT NULL,
    [PolicyThemeRegisterId]                    INT      NOT NULL,
    [RoleId]                                   SMALLINT NOT NULL,
    [PolicyThemeProcedureOwner]                BIT      NOT NULL,
    [PolicyThemeProcedureReviewer]             BIT      NOT NULL,
    [PolicyThemeProcedureSignatory]            BIT      NOT NULL,
    [ActiveFlag]                               BIT      CONSTRAINT [DF_PTPRR_AF] DEFAULT ((1)) NOT NULL,
    [ActiveFromDatetime]                       DATETIME CONSTRAINT [DF_PTPRR_AFDT] DEFAULT (getdate()) NOT NULL,
    [ActiveToDatetime]                         DATETIME CONSTRAINT [DF_PTPRR_ATDT] DEFAULT ('2020-12-31 12:00') NOT NULL,
    [PolicyThemeProcedureLastModifiedDatetime] DATETIME CONSTRAINT [DF_PTPRR_PTPLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKPolicyThemeProcedureRoleRelationship] PRIMARY KEY CLUSTERED ([PolicyThemeProcedureId] ASC, [PolicyThemeRegisterId] ASC, [RoleId] ASC),
    CONSTRAINT [PolicyThemeProcedureRoleRelationshipPolicyThemeRegisterId] FOREIGN KEY ([PolicyThemeRegisterId]) REFERENCES [Organisation].[PolicyThemeRegister] ([PolicyThemeRegisterId]),
    CONSTRAINT [PolicyThemeProcedureRoleRelationshipRoleId] FOREIGN KEY ([RoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

