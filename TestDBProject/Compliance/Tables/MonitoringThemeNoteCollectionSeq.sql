CREATE TABLE [Compliance].[MonitoringThemeNoteCollectionSeq] (
    [MonitoringThemeNoteCollectionSeqId] INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringThemeNoteCollection]      INT              NULL,
    [JoinGUID]                           UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PKMonitoringThemeNoteCollectionSeq] PRIMARY KEY CLUSTERED ([MonitoringThemeNoteCollectionSeqId] ASC)
);

