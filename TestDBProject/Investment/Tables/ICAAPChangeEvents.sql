CREATE TABLE [Investment].[ICAAPChangeEvents] (
    [ICAAPChangeEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ICAAPChangeId]                        INT              NOT NULL,
    [ICAAPChangeEventTypeId]               SMALLINT         NOT NULL,
    [RecordedByPersonId]                   SMALLINT         NOT NULL,
    [EventDetails]                         VARCHAR (MAX)    NULL,
    [EventDate]                            DATETIME         NULL,
    [EventTrueFalse]                       BIT              NULL,
    [DocumentationFolderLink]              VARCHAR (2000)   NULL,
    [JoinGUID]                             UNIQUEIDENTIFIER NOT NULL,
    [ICAAPChangeEventCreationDatetime]     DATETIME         CONSTRAINT [DF_ICE_ICECD] DEFAULT (getdate()) NOT NULL,
    [ICAAPChangeEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_ICE_ICELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKICAAPChangeEventstime] PRIMARY KEY CLUSTERED ([ICAAPChangeEventId] ASC),
    CONSTRAINT [ComplaintsRegisterEventsComplaintRegisterId] FOREIGN KEY ([ICAAPChangeId]) REFERENCES [Investment].[ICAAPChanges] ([ICAAPChangeId]),
    CONSTRAINT [ICAAPChangeEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ICAAPChangeEventTypeId] FOREIGN KEY ([ICAAPChangeEventTypeId]) REFERENCES [Investment].[ICAAPChangeEventTypes] ([ICAAPChangeEventTypeId])
);

