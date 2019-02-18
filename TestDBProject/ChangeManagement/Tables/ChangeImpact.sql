CREATE TABLE [ChangeManagement].[ChangeImpact] (
    [ChangeImpactID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeImpactName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangeImpact] PRIMARY KEY CLUSTERED ([ChangeImpactID] ASC)
);

