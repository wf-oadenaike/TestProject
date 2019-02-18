﻿CREATE TABLE [dbo].[Compliance_WatchListRegister] (
    [WatchListRegisterId]    INT              IDENTITY (1, 1) NOT NULL,
    [Identifier]             VARCHAR (100)    NULL,
    [WatchlistId]            INT              NOT NULL,
    [ReasonTypeId]           SMALLINT         NOT NULL,
    [StatusId]               INT              NULL,
    [SubmittedByPersonId]    SMALLINT         NOT NULL,
    [ReviewedByPersonId]     SMALLINT         NULL,
    [AnticipatedRemovalDate] DATETIME         NULL,
    [DateSubmitted]          DATETIME         NULL,
    [JIRAIssueKey]           VARCHAR (255)    NULL,
    [BoxLink]                VARCHAR (255)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         CONSTRAINT [T_WLR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         CONSTRAINT [T_WLR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    CONSTRAINT [T_WLR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [Description]            VARCHAR (MAX)    NOT NULL,
    [IdentifierTypeId]       SMALLINT         NOT NULL,
    CONSTRAINT [PKWatchListRegister] PRIMARY KEY CLUSTERED ([WatchListRegisterId] ASC) WITH (FILLFACTOR = 80),
    FOREIGN KEY ([IdentifierTypeId]) REFERENCES [dbo].[Compliance_WatchlistIdentifierType] ([IdentifierTypeId]),
    CONSTRAINT [WatchlistRegisterReasonTypeId] FOREIGN KEY ([ReasonTypeId]) REFERENCES [dbo].[Compliance_WatchlistReasonType] ([ReasonTypeId]),
    CONSTRAINT [WatchlistRegisterReviewedByPersonId] FOREIGN KEY ([ReviewedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [WatchlistRegisterStatusId] FOREIGN KEY ([StatusId]) REFERENCES [Core].[FlowStatus] ([FlowStatusId]),
    CONSTRAINT [WatchlistRegisterSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [WatchlistRegisterWatchlistId] FOREIGN KEY ([WatchlistId]) REFERENCES [dbo].[Compliance_WatchLists] ([WatchlistId])
);

