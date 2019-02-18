CREATE TABLE [Organisation].[PolicyThemeMapping] (
    [ThemeProcedureId]  INT NOT NULL,
    [ThemeRegisterId]   INT NOT NULL,
    [PolicyProcedureId] INT NOT NULL,
    [PolicyRegisterId]  INT NOT NULL,
    CONSTRAINT [PKPolicyThemeMapping] PRIMARY KEY CLUSTERED ([ThemeProcedureId] ASC, [PolicyProcedureId] ASC),
    CONSTRAINT [PolicyThemeMappingPolicyProcedureId] FOREIGN KEY ([PolicyProcedureId]) REFERENCES [Organisation].[PolicyThemeProcedures] ([PolicyThemeProcedureId]),
    CONSTRAINT [PolicyThemeMappingPolicyRegisterId] FOREIGN KEY ([PolicyRegisterId]) REFERENCES [Organisation].[PolicyThemeRegister] ([PolicyThemeRegisterId]),
    CONSTRAINT [PolicyThemeMappingThemeProcedureId] FOREIGN KEY ([ThemeProcedureId]) REFERENCES [Organisation].[PolicyThemeProcedures] ([PolicyThemeProcedureId]),
    CONSTRAINT [PolicyThemeMappingThemeRegisterId] FOREIGN KEY ([ThemeRegisterId]) REFERENCES [Organisation].[PolicyThemeRegister] ([PolicyThemeRegisterId])
);

