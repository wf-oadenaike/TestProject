CREATE TABLE [Unquoted].[SecurityRevaluationEvents] (
    [RevaluationEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [SecurityRevaluationId]                INT              NOT NULL,
    [SecurityEventTypeId]                  SMALLINT         NOT NULL,
    [SubmittedByPersonId]                  SMALLINT         CONSTRAINT [DF_SRE_CESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                         VARCHAR (MAX)    NULL,
    [EventDate]                            DATETIME         NULL,
    [EventTrueFalse]                       BIT              NULL,
    [DocumentationFolderLink]              VARCHAR (2000)   NULL,
    [JoinGUID]                             UNIQUEIDENTIFIER NOT NULL,
    [RevaluationEventCreationDatetime]     DATETIME         CONSTRAINT [DF_SRE_CECD] DEFAULT (getdate()) NOT NULL,
    [RevaluationEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_SRE_CELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                DATETIME         CONSTRAINT [DF_SRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                 DATETIME         CONSTRAINT [DF_SRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]               NVARCHAR (50)    CONSTRAINT [DF_SRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                INT              CONSTRAINT [DF_SRE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]               ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]            DATETIME         CONSTRAINT [DF_SRE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKSecurityRevaluationEvents] PRIMARY KEY CLUSTERED ([RevaluationEventId] ASC),
    CONSTRAINT [SecurityRevaluationEventsSecurityEventTypeId] FOREIGN KEY ([SecurityEventTypeId]) REFERENCES [Unquoted].[SecurityEventTypes] ([SecurityEventTypeId]),
    CONSTRAINT [SecurityRevaluationEventsSecurityRevaluationId] FOREIGN KEY ([SecurityRevaluationId]) REFERENCES [Unquoted].[SecurityRevaluation] ([SecurityRevaluationId]),
    CONSTRAINT [SecurityRevaluationEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

