CREATE TABLE [Organisation].[MeetingOccurrence] (
    [MeetingRegisterId]                     SMALLINT         NOT NULL,
    [MeetingDateTime]                       DATETIME         NOT NULL,
    [MeetingNotes]                          VARCHAR (2048)   NULL,
    [JIRAEpicKey]                           VARCHAR (2000)   NULL,
    [ActiveFlag]                            BIT              CONSTRAINT [DF_MO_AF] DEFAULT ((1)) NOT NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                   UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [MeetingOccurrenceCreationDatetime]     DATETIME         CONSTRAINT [DF_MO_MOCDT] DEFAULT (getdate()) NOT NULL,
    [MeetingOccurrenceLastModifiedDatetime] DATETIME         CONSTRAINT [DF_MO_MOLMDT] DEFAULT (getdate()) NOT NULL,
    [MeetingOccurrenceId]                   INT              IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PKMeetingOccurrence] PRIMARY KEY CLUSTERED ([MeetingOccurrenceId] ASC),
    CONSTRAINT [MeetingOccurrenceRegisterId] FOREIGN KEY ([MeetingRegisterId]) REFERENCES [Organisation].[MeetingsRegister] ([MeetingRegisterId])
);


GO
CREATE TRIGGER [Organisation].[MeetingOccurrenceTri]
ON [Organisation].[MeetingOccurrence]
FOR INSERT, UPDATE, DELETE
AS
BEGIN 
		SET NOCOUNT ON
		EXEC [Scheduler].usp_MergeMeetingOccurrence
END
