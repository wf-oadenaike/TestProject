CREATE TABLE [Organisation].[WhistleblowingEvents] (
    [WhistleblowingEventId]               INT              IDENTITY (1, 1) NOT NULL,
    [WhistleblowingId]                    INT              NOT NULL,
    [WhistleblowingEventTypeId]           SMALLINT         NOT NULL,
    [RecordedByPersonId]                  SMALLINT         NULL,
    [EventDetails]                        VARCHAR (MAX)    NULL,
    [EventDate]                           DATETIME         NULL,
    [DocumentationFolderLink]             VARCHAR (2000)   NULL,
    [JoinGUID]                            UNIQUEIDENTIFIER NOT NULL,
    [WhistleblowingEventCreationDate]     DATETIME         CONSTRAINT [DF_WBE_CECD] DEFAULT (getdate()) NOT NULL,
    [WhistleblowingEventLastModifiedDate] DATETIME         CONSTRAINT [DF_WBE_CELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKWhistleblowingEvents] PRIMARY KEY CLUSTERED ([WhistleblowingEventId] ASC),
    CONSTRAINT [WhistleblowingEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [WhistleblowingEventsWhistleblowingEventTypeId] FOREIGN KEY ([WhistleblowingEventTypeId]) REFERENCES [Organisation].[WhistleblowingEventTypes] ([WhistleblowingEventTypeId]),
    CONSTRAINT [WhistleblowingEventsWhistleblowingId] FOREIGN KEY ([WhistleblowingId]) REFERENCES [Organisation].[Whistleblowing] ([WhistleblowingId])
);

