CREATE TABLE [Compliance].[MonitoringNoteTypes] (
    [MonitoringNoteTypeId]           INT           IDENTITY (1, 1) NOT NULL,
    [MonitoringNoteType]             VARCHAR (128) NOT NULL,
    [MonitoringNoteTypeCreationDate] DATETIME      CONSTRAINT [DF_MNT_MNTCDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKMonitoringNoteTypes] PRIMARY KEY CLUSTERED ([MonitoringNoteTypeId] ASC)
);

