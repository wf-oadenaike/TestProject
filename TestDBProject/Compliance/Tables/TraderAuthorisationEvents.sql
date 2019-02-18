﻿CREATE TABLE [Compliance].[TraderAuthorisationEvents] (
    [TraderAuthorisationEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [TraderAuthorisationId]                        INT              NOT NULL,
    [EventType]                                    VARCHAR (50)     NOT NULL,
    [RecordedByPersonId]                           SMALLINT         CONSTRAINT [DF_TAE_TAESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                                 VARCHAR (MAX)    NULL,
    [EventDate]                                    DATETIME         NULL,
    [EventTrueFalse]                               BIT              NULL,
    [Status]                                       VARCHAR (50)     NULL,
    [JiraKey]                                      VARCHAR (2000)   NULL,
    [DocumentationFolderLink]                      VARCHAR (2000)   NULL,
    [JoinGUID]                                     UNIQUEIDENTIFIER NOT NULL,
    [TraderAuthorisationEventCreationDatetime]     DATETIME         CONSTRAINT [DF_TAE_TAECD] DEFAULT (getdate()) NOT NULL,
    [TraderAuthorisationEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_TAE_TAELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                        DATETIME         CONSTRAINT [DF_TAE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                         DATETIME         CONSTRAINT [DF_TAE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                       NVARCHAR (50)    CONSTRAINT [DF_TAE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                        INT              CONSTRAINT [DF_TAE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                       ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                    DATETIME         CONSTRAINT [DF_TAE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTraderAuthorisationEvents] PRIMARY KEY CLUSTERED ([TraderAuthorisationEventId] ASC),
    CONSTRAINT [TraderAuthorisationEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TraderAuthorisationEventsTraderAuthorisationId] FOREIGN KEY ([TraderAuthorisationId]) REFERENCES [Compliance].[TraderAuthorisation] ([TraderAuthorisationId])
);
