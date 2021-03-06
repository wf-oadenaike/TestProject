﻿CREATE TABLE [dbo].[CircleProcessScheduledTasks] (
    [Id]                     INT           IDENTITY (1, 1) NOT NULL,
    [CircleProcessId]        INT           NULL,
    [Frequency]              VARCHAR (255) NULL,
    [FrequencyDay]           INT           NULL,
    [FrequencyStart]         INT           NULL,
    [ProjectKey]             VARCHAR (255) NULL,
    [EpicKey]                VARCHAR (255) NULL,
    [IssueType]              VARCHAR (255) NULL,
    [ReporterPersonId]       SMALLINT      NULL,
    [AssigneePersonId]       SMALLINT      NULL,
    [DueDateOffset]          SMALLINT      NULL,
    [Summary]                VARCHAR (MAX) NULL,
    [Purpose]                VARCHAR (MAX) NULL,
    [Outcome]                VARCHAR (MAX) NULL,
    [Description]            VARCHAR (MAX) NULL,
    [IsActive]               BIT           CONSTRAINT [default_CircleProcessScheduledTasks_IsAcive] DEFAULT ('1') NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80),
    FOREIGN KEY ([AssigneePersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    FOREIGN KEY ([CircleProcessId]) REFERENCES [dbo].[CircleProcesses] ([Id]),
    FOREIGN KEY ([ReporterPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

