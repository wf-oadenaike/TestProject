CREATE TABLE [dbo].[Compliance_KYCEvents] (
    [EventID]                INT              IDENTITY (1, 1) NOT NULL,
    [EventTypeID]            SMALLINT         NOT NULL,
    [EventDetails]           VARCHAR (2000)   NULL,
    [EventDate]              DATETIME         NOT NULL,
    [ChecklistID]            INT              NOT NULL,
    [SubmittedByPersonID]    SMALLINT         NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [JiraIssueKey]           NVARCHAR (50)    NULL,
    CONSTRAINT [PKCompliance_KYCEvents] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [KCSubmittedByPersonID] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [KYCChecklistID] FOREIGN KEY ([ChecklistID]) REFERENCES [dbo].[Compliance_KYCChecklist] ([ChecklistID]),
    CONSTRAINT [KYCEventTypeID] FOREIGN KEY ([EventTypeID]) REFERENCES [dbo].[Compliance_KYCEventTypes] ([EventTypeID])
);

