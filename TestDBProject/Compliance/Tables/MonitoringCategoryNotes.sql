CREATE TABLE [Compliance].[MonitoringCategoryNotes] (
    [MonitoringCategoryNoteId]      INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringCategoryId]          INT              NOT NULL,
    [CategoryNote]                  VARCHAR (MAX)    NOT NULL,
    [MonitoringNoteTypeId]          INT              NOT NULL,
    [ValidFromDate]                 DATETIME         NULL,
    [ValidToDate]                   DATETIME         NULL,
    [OccurrenceDate]                DATETIME         NULL,
    [SubmittedByPersonId]           SMALLINT         NULL,
    [SubmittedDate]                 DATETIME         CONSTRAINT [DF_MCN_MCNSD] DEFAULT (getdate()) NOT NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [CategoryNoteCreationDate]      DATETIME         CONSTRAINT [DF_MCN_MCNCDT] DEFAULT (getdate()) NOT NULL,
    [CategoryNoteLastModifiedDate]  DATETIME         CONSTRAINT [DF_MCN_MCNLMDT] DEFAULT (getdate()) NOT NULL,
    [MonitoringNoteCollectionSeqId] INT              NULL,
    CONSTRAINT [PKMonitoringCategoryNotes] PRIMARY KEY CLUSTERED ([MonitoringCategoryNoteId] ASC),
    CONSTRAINT [MonitoringCategoryNotesMonitoringCategoryId] FOREIGN KEY ([MonitoringCategoryId]) REFERENCES [Compliance].[MonitoringCategories] ([MonitoringCategoryId]),
    CONSTRAINT [MonitoringCategoryNotesMonitoringNoteTypeId] FOREIGN KEY ([MonitoringNoteTypeId]) REFERENCES [Compliance].[MonitoringNoteTypes] ([MonitoringNoteTypeId]),
    CONSTRAINT [MonitoringCategoryNotesSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

