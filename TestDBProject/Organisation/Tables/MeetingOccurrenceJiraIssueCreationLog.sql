CREATE TABLE [Organisation].[MeetingOccurrenceJiraIssueCreationLog] (
    [MeetingOccurrenceId]                   INT      NOT NULL,
    [MeetingAgendaItemId]                   SMALLINT NOT NULL,
    [MeetingOccurrenceCreationDatetime]     DATETIME CONSTRAINT [DF_MOJICL_MOCDT] DEFAULT (getdate()) NOT NULL,
    [MeetingOccurrenceLastModifiedDatetime] DATETIME CONSTRAINT [DF_MOJICL_MOLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKMeetingOccurrenceJiraIssueCreationLog] PRIMARY KEY CLUSTERED ([MeetingOccurrenceId] ASC, [MeetingAgendaItemId] ASC),
    CONSTRAINT [MeetingOccurrenceJiraIssueCreationLogMeetingAgendaItemId] FOREIGN KEY ([MeetingAgendaItemId]) REFERENCES [Organisation].[MeetingAgendaItems] ([MeetingAgendaItemId]),
    CONSTRAINT [MeetingOccurrenceJiraIssueCreationLogMeetingOccurrenceId] FOREIGN KEY ([MeetingOccurrenceId]) REFERENCES [Organisation].[MeetingOccurrence] ([MeetingOccurrenceId])
);

