CREATE TABLE [ChangeManagement].[ChangeRisk] (
    [ChangeRiskID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeRiskName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangeRisk] PRIMARY KEY CLUSTERED ([ChangeRiskID] ASC)
);

