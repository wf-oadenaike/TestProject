CREATE TABLE [dbo].[IT_ScheduledTasks] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [ProcessId]        INT           NULL,
    [Frequency1]       VARCHAR (255) NULL,
    [Frequency2]       VARCHAR (255) NULL,
    [Frequency3]       VARCHAR (255) NULL,
    [ProjectKey]       VARCHAR (255) NULL,
    [EpicKey]          VARCHAR (255) NULL,
    [IssueType]        VARCHAR (255) NULL,
    [ReporterPersonId] SMALLINT      NULL,
    [AssigneePersonId] SMALLINT      NULL,
    [DueDateOffset]    SMALLINT      NULL,
    [Summary]          VARCHAR (MAX) NULL,
    [Purpose]          VARCHAR (MAX) NULL,
    [Outcome]          VARCHAR (MAX) NULL,
    [Description]      VARCHAR (MAX) NULL,
    [IsActive]         BIT           CONSTRAINT [default_IsAcive] DEFAULT ('1') NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80),
    FOREIGN KEY ([AssigneePersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    FOREIGN KEY ([ProcessId]) REFERENCES [dbo].[IT_Processes] ([Id]),
    FOREIGN KEY ([ReporterPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

