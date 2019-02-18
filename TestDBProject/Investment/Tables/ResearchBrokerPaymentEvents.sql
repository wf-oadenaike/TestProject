CREATE TABLE [Investment].[ResearchBrokerPaymentEvents] (
    [ResearchBrokerPaymentEventId] INT              IDENTITY (1, 1) NOT NULL,
    [ResearchBrokerPaymentId]      INT              NOT NULL,
    [EventTypeId]                  SMALLINT         NOT NULL,
    [EventDetails]                 NVARCHAR (255)   NULL,
    [EventDate]                    DATETIME         NULL,
    [SubTaskJiraKey]               NVARCHAR (255)   NULL,
    [SubmittedByPersonId]          SMALLINT         NULL,
    [DocumentationFolderLink]      NVARCHAR (255)   NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]        DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]         DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]       NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_LASTMODIFIED]    DATETIME         NULL,
    CONSTRAINT [PKResearchBrokerPaymentEvents] PRIMARY KEY CLUSTERED ([ResearchBrokerPaymentEventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [EventType] FOREIGN KEY ([EventTypeId]) REFERENCES [Investment].[ResearchBrokerPaymentEventTypes] ([EventTypeId]),
    CONSTRAINT [RBPESubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RBPESubmittedByPersonId1] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

