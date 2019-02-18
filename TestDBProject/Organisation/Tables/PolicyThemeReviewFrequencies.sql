CREATE TABLE [Organisation].[PolicyThemeReviewFrequencies] (
    [PolicyThemeReviewFrequencyId] INT          IDENTITY (1, 1) NOT NULL,
    [ReviewFrequencyName]          VARCHAR (25) NOT NULL,
    [ReviewWithin]                 SMALLINT     DEFAULT ((30)) NOT NULL,
    [ValidityPeriod]               SMALLINT     DEFAULT ((1)) NOT NULL,
    [Frequency]                    VARCHAR (2)  DEFAULT ('yy') NOT NULL,
    CONSTRAINT [PKPolicyThemeReviewFrequencies] PRIMARY KEY CLUSTERED ([PolicyThemeReviewFrequencyId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIPolicyThemeReviewFrequencies]
    ON [Organisation].[PolicyThemeReviewFrequencies]([ReviewFrequencyName] ASC);

