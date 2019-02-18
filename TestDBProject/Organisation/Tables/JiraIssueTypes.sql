CREATE TABLE [Organisation].[JiraIssueTypes] (
    [IssueTypeId]          INT            NOT NULL,
    [JiraBK]               VARCHAR (60)   NOT NULL,
    [SequenceNo]           DECIMAL (18)   NULL,
    [TypeName]             VARCHAR (60)   NOT NULL,
    [IssueTypeDescription] VARCHAR (2048) NULL,
    PRIMARY KEY CLUSTERED ([IssueTypeId] ASC),
    CONSTRAINT [IDX_JiraBK] UNIQUE NONCLUSTERED ([JiraBK] ASC)
);

