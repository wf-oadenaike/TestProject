CREATE TABLE [Organisation].[MeetingJiraIssueTypeLag] (
    [IssueTypeId] INT      NOT NULL,
    [LagLead]     SMALLINT NOT NULL,
    PRIMARY KEY CLUSTERED ([IssueTypeId] ASC),
    CONSTRAINT [MeetingJiraIssueTypeLagIssueTypeId] FOREIGN KEY ([IssueTypeId]) REFERENCES [Organisation].[JiraIssueTypes] ([IssueTypeId])
);

