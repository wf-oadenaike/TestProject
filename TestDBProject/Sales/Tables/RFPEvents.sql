CREATE TABLE [Sales].[RFPEvents] (
    [RFPEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [RFPId]                        INT              NOT NULL,
    [EventTypeId]                  SMALLINT         NOT NULL,
    [SubmittedByPersonId]          SMALLINT         CONSTRAINT [DF_RFPE_RFPESP] DEFAULT ((-1)) NOT NULL,
    [ReviewedById]                 SMALLINT         CONSTRAINT [DF_RFPE_RFPERBI] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                 VARCHAR (MAX)    NULL,
    [EventDate]                    DATETIME         NULL,
    [ReviewComments]               VARCHAR (MAX)    NULL,
    [EventTrueFalse]               BIT              NULL,
    [DepartmentId]                 SMALLINT         NULL,
    [JiraSubTaskKey]               VARCHAR (128)    NULL,
    [DocumentationFolderLink]      VARCHAR (2000)   NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [RFPEventCreationDate]         DATETIME         CONSTRAINT [DF_RFPE_RFPECD] DEFAULT (getdate()) NOT NULL,
    [RFPEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_RFPE_RFPELMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKRFPEvents] PRIMARY KEY CLUSTERED ([RFPEventId] ASC),
    CONSTRAINT [RFPEventsDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [RFPEventsEventTypeId] FOREIGN KEY ([EventTypeId]) REFERENCES [Sales].[RFPEventTypes] ([RFPEventTypeId]),
    CONSTRAINT [RFPEventsReviewedById] FOREIGN KEY ([ReviewedById]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RFPEventsRFPId] FOREIGN KEY ([RFPId]) REFERENCES [Sales].[RFPRegister] ([RFPId]),
    CONSTRAINT [RFPEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

