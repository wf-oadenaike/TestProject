CREATE TABLE [ChangeManagement].[ChangeComplexity] (
    [ChangeComplexityID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeComplexityName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangeComplexity] PRIMARY KEY CLUSTERED ([ChangeComplexityID] ASC)
);

