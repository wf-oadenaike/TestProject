CREATE TABLE [Risk].[RiskAppetiteKRIEvents] (
    [RiskAppetiteKRIEventId]    INT              IDENTITY (1, 1) NOT NULL,
    [RiskAppetiteKRIRegisterId] INT              NOT NULL,
    [RiskKRIEventTypeID]        INT              NOT NULL,
    [SubmittedByPersonId]       SMALLINT         NOT NULL,
    [RiskKRIEventDate]          DATETIME         NOT NULL,
    [RiskKRIEventDetails]       VARCHAR (2000)   NULL,
    [JiraIssueKey]              NVARCHAR (50)    NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    NULL,
    CONSTRAINT [PKRiskAppetiteKRIEvents] PRIMARY KEY CLUSTERED ([RiskAppetiteKRIEventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [RAKERiskAppetiteRegisterID] FOREIGN KEY ([RiskAppetiteKRIRegisterId]) REFERENCES [Risk].[RiskAppetiteKRIRegister] ([RiskAppetiteKRIRegisterId]),
    CONSTRAINT [RAKERiskKRIEventTypeID] FOREIGN KEY ([RiskKRIEventTypeID]) REFERENCES [Risk].[RiskRegisterEventTypes] ([RiskEventTypeID]),
    CONSTRAINT [RAKESubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

