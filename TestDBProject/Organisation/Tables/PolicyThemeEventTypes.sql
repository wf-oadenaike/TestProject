CREATE TABLE [Organisation].[PolicyThemeEventTypes] (
    [PolicyThemeEventTypeId]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [PolicyThemeEventTypeBK]      VARCHAR (25)  NOT NULL,
    [PolicyThemeEventDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKPolicyThemeEventTypes] PRIMARY KEY CLUSTERED ([PolicyThemeEventTypeBK] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIPolicyThemeEventTypes]
    ON [Organisation].[PolicyThemeEventTypes]([PolicyThemeEventTypeId] ASC);

