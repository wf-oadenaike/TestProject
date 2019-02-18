CREATE TABLE [Compliance].[MonitoringThemeNotes] (
    [MonitoringThemeNoteId]                    INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringThemeId]                        INT              NOT NULL,
    [SubmittedByPersonId]                      SMALLINT         NULL,
    [SubmittedDate]                            DATETIME         CONSTRAINT [DF_MTN_MTNSD] DEFAULT (getdate()) NOT NULL,
    [ThemeNote]                                VARCHAR (MAX)    NULL,
    [MonitoringNoteTypeId]                     INT              NULL,
    [MonitoringThemeNoteCollectionSeqId]       INT              NULL,
    [OccurrenceDate]                           DATETIME         NULL,
    [OutlierCount]                             INT              NULL,
    [JoinGUID]                                 UNIQUEIDENTIFIER NOT NULL,
    [MonitoringThemeNotesCreationDatetime]     DATETIME         CONSTRAINT [DF_MTN_MTNCDT] DEFAULT (getdate()) NOT NULL,
    [MonitoringThemeNotesLastModifiedDatetime] DATETIME         CONSTRAINT [DF_MTN_MTNLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKMonitoringThemeNotes] PRIMARY KEY CLUSTERED ([MonitoringThemeNoteId] ASC),
    CONSTRAINT [MonitoringThemeNotesMonitoringNoteTypeId] FOREIGN KEY ([MonitoringNoteTypeId]) REFERENCES [Compliance].[MonitoringNoteTypes] ([MonitoringNoteTypeId]),
    CONSTRAINT [MonitoringThemeNotesMonitoringThemeId] FOREIGN KEY ([MonitoringThemeId]) REFERENCES [Compliance].[MonitoringThemes] ([MonitoringThemeId]),
    CONSTRAINT [MonitoringThemeNotesSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

