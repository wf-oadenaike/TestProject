CREATE TABLE [ChangeManagement].[ChangeManagementEventTypes] (
    [ChangeManagementEventTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeManagementEventType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKChangeManagementEventTypes] PRIMARY KEY CLUSTERED ([ChangeManagementEventTypeId] ASC)
);

