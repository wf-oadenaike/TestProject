CREATE TABLE [Organisation].[FinanceRequestEvents] (
    [FinanceRequestEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [FinanceRequestId]                        INT              NOT NULL,
    [FinanceRequestEventType]                 VARCHAR (50)     NOT NULL,
    [RecordedByPersonId]                      SMALLINT         NULL,
    [EventDetails]                            VARCHAR (MAX)    NULL,
    [EventDate]                               DATETIME         NULL,
    [EventTrueFalse]                          BIT              NULL,
    [DocumentationFolderLink]                 VARCHAR (2000)   NULL,
    [JoinGUID]                                UNIQUEIDENTIFIER NOT NULL,
    [FinanceRequestEventCreationDatetime]     DATETIME         CONSTRAINT [DF_FRE_FRECDT] DEFAULT (getdate()) NOT NULL,
    [FinanceRequestEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_FRE_FRELMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                   DATETIME         CONSTRAINT [DF_FRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                    DATETIME         CONSTRAINT [DF_FRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                  NVARCHAR (50)    CONSTRAINT [DF_FRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                   INT              CONSTRAINT [DF_FRE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                  ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]               DATETIME         CONSTRAINT [DF_FRE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKFinanceRequestEvents] PRIMARY KEY CLUSTERED ([FinanceRequestEventId] ASC),
    CONSTRAINT [FinanceRequestEventsFinanceRequestId] FOREIGN KEY ([FinanceRequestId]) REFERENCES [Organisation].[FinanceRequests] ([FinanceRequestId]),
    CONSTRAINT [FinanceRequestEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

