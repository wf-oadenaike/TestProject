CREATE TABLE [Risk].[RiskAppetiteEvents] (
    [RiskAppetiteEventId]    INT              IDENTITY (1, 1) NOT NULL,
    [RiskAppetiteRegisterId] INT              NOT NULL,
    [RiskEventTypeID]        INT              NOT NULL,
    [SubmittedByPersonId]    SMALLINT         NOT NULL,
    [RiskEventDate]          DATETIME         NOT NULL,
    [RiskEventDetails]       VARCHAR (2000)   NULL,
    [JiraIssueKey]           NVARCHAR (50)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    CONSTRAINT [PKRiskAppetiteEvents] PRIMARY KEY CLUSTERED ([RiskAppetiteEventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [RAERiskAppetiteRegisterID] FOREIGN KEY ([RiskAppetiteRegisterId]) REFERENCES [Risk].[RiskAppetiteRegister] ([RiskAppetiteRegisterId]),
    CONSTRAINT [RAERiskEventTypeID] FOREIGN KEY ([RiskEventTypeID]) REFERENCES [Risk].[RiskRegisterEventTypes] ([RiskEventTypeID]),
    CONSTRAINT [RAESubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

