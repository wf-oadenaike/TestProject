CREATE TABLE [Compliance].[ConflictsRegisterMeetings] (
    [ConflictId]                 INT            NOT NULL,
    [MeetingDate]                DATETIME       NOT NULL,
    [MeetingOutcome]             NVARCHAR (MAX) NOT NULL,
    [CreatedByPersionId]         SMALLINT       NOT NULL,
    [CreationDate]               DATETIME       CONSTRAINT [DF_CRM2_CDT] DEFAULT (getdate()) NOT NULL,
    [ConflictsRegisterMeetingID] INT            IDENTITY (1, 1) NOT NULL,
    [JIRAIssueKey]               VARCHAR (255)  NULL,
    CONSTRAINT [PKConflictsRegisterMeetings] PRIMARY KEY CLUSTERED ([ConflictsRegisterMeetingID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [ConflictsMeetingsCreatedByPersionId] FOREIGN KEY ([CreatedByPersionId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ConflictsRegisterMeetingsConflictId] FOREIGN KEY ([ConflictId]) REFERENCES [Compliance].[ConflictsRegisterPotential] ([ConflictId])
);

