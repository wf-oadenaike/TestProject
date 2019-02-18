CREATE TABLE [Investment].[ShareClassWaiverEvents] (
    [ShareClassWaiverEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ShareClassWaiverId]                        INT              NOT NULL,
    [ShareClassWaiverEventTypeId]               SMALLINT         NOT NULL,
    [SubmittedByPersonId]                       SMALLINT         CONSTRAINT [DF_SCWE_SLESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                              VARCHAR (MAX)    NULL,
    [EventDate]                                 DATETIME         NULL,
    [EventTrueFalse]                            BIT              NULL,
    [DocumentationFolderLink]                   VARCHAR (2000)   NULL,
    [JoinGUID]                                  UNIQUEIDENTIFIER NOT NULL,
    [ShareClassWaiverEventCreationDatetime]     DATETIME         CONSTRAINT [DF_SCWE_SCWECD] DEFAULT (getdate()) NOT NULL,
    [ShareClassWaiverEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_SCWE_SCWELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                     DATETIME         CONSTRAINT [DF_SCWE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                      DATETIME         CONSTRAINT [DF_SCWE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                    NVARCHAR (50)    CONSTRAINT [DF_SCWE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                     INT              CONSTRAINT [DF_SCWE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                 DATETIME         CONSTRAINT [DF_SCWE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKShareClassWaiverEvents] PRIMARY KEY CLUSTERED ([ShareClassWaiverEventId] ASC),
    CONSTRAINT [ShareClassWaiverEventsEventTypeId] FOREIGN KEY ([ShareClassWaiverEventTypeId]) REFERENCES [Investment].[ShareClassWaiverEventTypes] ([ShareClassWaiverEventTypeId]),
    CONSTRAINT [ShareClassWaiverEventsStopListId] FOREIGN KEY ([ShareClassWaiverId]) REFERENCES [Investment].[ShareClassWaiverRegister] ([ShareClassWaiverId]),
    CONSTRAINT [ShareClassWaiverEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

