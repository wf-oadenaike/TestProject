CREATE TABLE [ChangeManagement].[ChangeUrgency] (
    [ChangeUrgencyID]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ChangeUrgencyName] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PKChangeUrgency] PRIMARY KEY CLUSTERED ([ChangeUrgencyID] ASC)
);

