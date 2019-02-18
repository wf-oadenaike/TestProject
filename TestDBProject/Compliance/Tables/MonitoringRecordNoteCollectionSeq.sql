CREATE TABLE [Compliance].[MonitoringRecordNoteCollectionSeq] (
    [MonitoringRecordNoteCollectionSeqId] INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringRecordNoteCollection]      INT              NULL,
    [JoinGUID]                            UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PKMonitoringRecordNoteCollectionSeq] PRIMARY KEY CLUSTERED ([MonitoringRecordNoteCollectionSeqId] ASC)
);

