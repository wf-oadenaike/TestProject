CREATE TABLE [dbo].[NewOrgStructureChangeRequestEvents] (
    [EventID]                INT              IDENTITY (1, 1) NOT NULL,
    [EventTypeID]            SMALLINT         NOT NULL,
    [RequestID]              INT              NOT NULL,
    [EventDetails]           VARCHAR (MAX)    NULL,
    [EventDate]              DATETIME         NOT NULL,
    [SubmittedByPersonID]    SMALLINT         NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [JiraIssueKey]           VARCHAR (50)     NULL,
    CONSTRAINT [PKNewOrgStructureChangeRequestEvents] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [EventTypeID] FOREIGN KEY ([EventTypeID]) REFERENCES [dbo].[NewOrgStructureChangeRequestEventTypes] ([EventTypeID]),
    CONSTRAINT [NOSubmittedByPersonID] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RequestID] FOREIGN KEY ([RequestID]) REFERENCES [dbo].[NewOrgStructureChangeRequestRegister] ([RequestID])
);

