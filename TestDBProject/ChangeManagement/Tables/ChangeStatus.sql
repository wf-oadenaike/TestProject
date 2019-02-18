CREATE TABLE [ChangeManagement].[ChangeStatus] (
    [ChangeStatusID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeStatusName] NVARCHAR (40) NOT NULL,
    CONSTRAINT [PKChangeStatus] PRIMARY KEY CLUSTERED ([ChangeStatusID] ASC)
);

