﻿CREATE TABLE [PolicyProc].[SignatoryReviewEvents] (
    [SignatoryReviewEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [EventId]                                  INT              NOT NULL,
    [SignatoryRoleId]                          SMALLINT         NOT NULL,
    [SignatoryPersonId]                        SMALLINT         NULL,
    [EventDetails]                             VARCHAR (MAX)    NULL,
    [EventDate]                                DATETIME         NULL,
    [EventStatus]                              VARCHAR (25)     NULL,
    [EventTrueFalse]                           BIT              NULL,
    [JiraTaskKey]                              VARCHAR (128)    NULL,
    [SubmittedByPersonId]                      SMALLINT         CONSTRAINT [DF_SRE_SP] DEFAULT ((-1)) NOT NULL,
    [LastModifiedByPersonId]                   SMALLINT         NULL,
    [DocumentationFolderLink]                  VARCHAR (2000)   NULL,
    [JoinGUID]                                 UNIQUEIDENTIFIER NOT NULL,
    [SignatoryReviewEventCreationDatetime]     DATETIME         CONSTRAINT [DF_SRE_EVTCDT] DEFAULT (getdate()) NOT NULL,
    [SignatoryReviewEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_SRE_EVTLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                    DATETIME         CONSTRAINT [DF_SRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                     DATETIME         CONSTRAINT [DF_SRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                   NVARCHAR (50)    CONSTRAINT [DF_SRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                    INT              CONSTRAINT [DF_SRE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                   ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                DATETIME         CONSTRAINT [DF_SRE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKSignatoryReviewEvents] PRIMARY KEY CLUSTERED ([SignatoryReviewEventId] ASC),
    CONSTRAINT [SignatoryReviewEventsCreatedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [SignatoryReviewEventsEventId] FOREIGN KEY ([EventId]) REFERENCES [PolicyProc].[Events] ([EventId]),
    CONSTRAINT [SignatoryReviewEventsLastModifiedByPersonId] FOREIGN KEY ([LastModifiedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [SignatoryReviewEventsSignatoryPersonId] FOREIGN KEY ([SignatoryPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [SignatoryReviewEventsSignatoryRoleId] FOREIGN KEY ([SignatoryRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);

