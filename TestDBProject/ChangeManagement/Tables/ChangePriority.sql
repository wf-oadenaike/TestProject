CREATE TABLE [ChangeManagement].[ChangePriority] (
    [ChangePriorityID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangePriorityName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangePriority] PRIMARY KEY CLUSTERED ([ChangePriorityID] ASC)
);

