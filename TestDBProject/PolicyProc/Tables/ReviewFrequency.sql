CREATE TABLE [PolicyProc].[ReviewFrequency] (
    [ReviewFrequencyId]   INT          IDENTITY (1, 1) NOT NULL,
    [ReviewFrequencyName] VARCHAR (25) NOT NULL,
    [ReviewWithinDays]    SMALLINT     CONSTRAINT [DF_RF_RWD] DEFAULT ((30)) NOT NULL,
    CONSTRAINT [PKReviewFrequency] PRIMARY KEY CLUSTERED ([ReviewFrequencyId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIReviewFrequency]
    ON [PolicyProc].[ReviewFrequency]([ReviewFrequencyName] ASC);

