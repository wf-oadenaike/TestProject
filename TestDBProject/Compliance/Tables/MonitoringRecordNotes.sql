CREATE TABLE [Compliance].[MonitoringRecordNotes] (
    [MonitoringRecordNoteId]                    INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringThemeId]                         INT              NOT NULL,
    [RecordId]                                  INT              NOT NULL,
    [SubmittedByPersonId]                       SMALLINT         NULL,
    [SubmittedDate]                             DATETIME         CONSTRAINT [DF_MN_MNSD] DEFAULT (getdate()) NOT NULL,
    [EventDetailsNote]                          VARCHAR (MAX)    NULL,
    [ComplianceConcernsNote]                    VARCHAR (MAX)    NULL,
    [FirstLineResponseNote]                     VARCHAR (MAX)    NULL,
    [GovernanceNote]                            VARCHAR (MAX)    NULL,
    [OccurrenceDate]                            DATETIME         NULL,
    [IsProcessed]                               BIT              CONSTRAINT [DF_MN_MNIS] DEFAULT ((0)) NOT NULL,
    [MonitoringRecordNotesCreationDatetime]     DATETIME         CONSTRAINT [DF_MTN_MNCDT] DEFAULT (getdate()) NOT NULL,
    [MonitoringRecordNotesLastModifiedDatetime] DATETIME         CONSTRAINT [DF_MTN_MNLMDT] DEFAULT (getdate()) NOT NULL,
    [MonitoringRecordNoteCollectionSeqId]       INT              NULL,
    [ActionRequired]                            VARCHAR (25)     NULL,
    [JoinGUID]                                  UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PKMonitoringRecordNotes] PRIMARY KEY CLUSTERED ([MonitoringRecordNoteId] ASC),
    CONSTRAINT [MonitoringRecordNotesMonitoringThemeId] FOREIGN KEY ([MonitoringThemeId]) REFERENCES [Compliance].[MonitoringThemes] ([MonitoringThemeId]),
    CONSTRAINT [MonitoringRecordNotesSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

