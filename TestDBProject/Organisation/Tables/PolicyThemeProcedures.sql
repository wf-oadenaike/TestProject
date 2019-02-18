CREATE TABLE [Organisation].[PolicyThemeProcedures] (
    [PolicyThemeProcedureId]     INT       IDENTITY (1, 1) NOT NULL,
    [PolicyThemeRegisterId]      INT       NOT NULL,
    [PTPCategoryId]              SMALLINT  NOT NULL,
    [PolicyThemeProcedureNameBK] [sysname] NOT NULL,
    [ActiveFlag]                 BIT       CONSTRAINT [DF_PTP_AF] DEFAULT ((1)) NOT NULL,
    [ActiveFromDatetime]         DATETIME  CONSTRAINT [DF_PTP_AFDT] DEFAULT (getdate()) NOT NULL,
    [ActiveToDatetime]           DATETIME  CONSTRAINT [DF_PTP_ATDT] DEFAULT ('2020-012-31 12:00') NOT NULL,
    CONSTRAINT [PKPolicyThemeProcedures] PRIMARY KEY CLUSTERED ([PolicyThemeProcedureNameBK] ASC, [PTPCategoryId] ASC, [PolicyThemeRegisterId] ASC),
    CONSTRAINT [PolicyThemeProceduresPolicyThemeRegisterId] FOREIGN KEY ([PolicyThemeRegisterId]) REFERENCES [Organisation].[PolicyThemeRegister] ([PolicyThemeRegisterId]),
    CONSTRAINT [PolicyThemeProceduresPTPCategoryId] FOREIGN KEY ([PTPCategoryId]) REFERENCES [Organisation].[PolicyThemeProcedureCategories] ([PTPCategoryId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIPolicyThemeProcedures]
    ON [Organisation].[PolicyThemeProcedures]([PolicyThemeProcedureId] ASC);

