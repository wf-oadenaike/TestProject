CREATE TABLE [Compliance].[MonitoringNoteCollectionSeq] (
    [MonitoringNoteCollectionSeqId] INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringNoteCollection]      INT              NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PKMonitoringNoteCollectionSeq] PRIMARY KEY CLUSTERED ([MonitoringNoteCollectionSeqId] ASC)
);

