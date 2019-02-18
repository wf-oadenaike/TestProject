CREATE TABLE [Sales].[DueDiligenceRequestEvents] (
    [RequestEventID]         SMALLINT         IDENTITY (1, 1) NOT NULL,
    [ClientRequestID]        INT              NULL,
    [EventType]              VARCHAR (120)    NULL,
    [ReviewerID]             SMALLINT         NULL,
    [SubmittedByPersonID]    INT              NULL,
    [EventDetails]           VARCHAR (MAX)    NULL,
    [EventDate]              DATETIME         NULL,
    [EventStatus]            VARCHAR (50)     NULL,
    [JiraIssueKey]           VARCHAR (120)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         CONSTRAINT [DDRET_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         CONSTRAINT [DDRET_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    CONSTRAINT [DDRET_CSCB] DEFAULT ('UNKNOWN') NULL,
    [EventTrueFalse]         BIT              NULL,
    CONSTRAINT [PK_DDRET_RequestEventID] PRIMARY KEY CLUSTERED ([RequestEventID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [DDRET_ClientRequestID] FOREIGN KEY ([ClientRequestID]) REFERENCES [Sales].[DueDiligenceClientRequest] ([ClientRequestID]),
    CONSTRAINT [DDRET_ReviewerID] FOREIGN KEY ([ReviewerID]) REFERENCES [Core].[Persons] ([PersonId])
);

