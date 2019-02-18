CREATE TABLE [ChangeManagement].[ChangeServiceTypes] (
    [ChangeServiceTypeID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeServiceTypeName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangeServiceTypes] PRIMARY KEY CLUSTERED ([ChangeServiceTypeID] ASC)
);

