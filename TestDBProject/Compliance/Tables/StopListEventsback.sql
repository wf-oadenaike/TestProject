﻿CREATE TABLE [Compliance].[StopListEventsback] (
    [StopListEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [StopListId]                        INT              NOT NULL,
    [StopListEventTypeId]               SMALLINT         NOT NULL,
    [SubmittedByPersonId]               SMALLINT         CONSTRAINT [DF_SLE_SLESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                      VARCHAR (MAX)    NULL,
    [EventDate]                         DATETIME         NULL,
    [EventTrueFalse]                    BIT              NULL,
    [JIRAIssueKey]                      VARCHAR (255)    NULL,
    [DocumentationFolderLink]           VARCHAR (2000)   NULL,
    [JoinGUID]                          UNIQUEIDENTIFIER NOT NULL,
    [StopListEventCreationDatetime]     DATETIME         CONSTRAINT [DF_SLE_SLECD] DEFAULT (getdate()) NOT NULL,
    [StopListEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_SLE_SLELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]             DATETIME         CONSTRAINT [DF_SLE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]              DATETIME         CONSTRAINT [DF_SLE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]            NVARCHAR (50)    CONSTRAINT [DF_SLE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]             INT              CONSTRAINT [DF_SLE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]            ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]         DATETIME         CONSTRAINT [DF_SLE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKStopListEvents] PRIMARY KEY CLUSTERED ([StopListEventId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [StopListEventsEventTypeId] FOREIGN KEY ([StopListEventTypeId]) REFERENCES [Compliance].[StopListEventTypes] ([StopListEventTypeId]),
    CONSTRAINT [StopListEventsStopListId] FOREIGN KEY ([StopListId]) REFERENCES [Compliance].[StopListRegisterback] ([StopListId]),
    CONSTRAINT [StopListEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

