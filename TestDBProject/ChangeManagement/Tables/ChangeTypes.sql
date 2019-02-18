CREATE TABLE [ChangeManagement].[ChangeTypes] (
    [ChangeTypeID]   SMALLINT       IDENTITY (1, 1) NOT NULL,
    [ChangeTypeName] NVARCHAR (255) NOT NULL,
    CONSTRAINT [PKChangeTypes] PRIMARY KEY CLUSTERED ([ChangeTypeID] ASC)
);

