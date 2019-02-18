CREATE TABLE [Compliance].[ComplaintsRegisterEvents] (
    [ComplaintsRegisterEventId]      INT              IDENTITY (1, 1) NOT NULL,
    [ComplaintRegisterId]            INT              NOT NULL,
    [ComplaintEventTypeId]           SMALLINT         NOT NULL,
    [RecordedByPersonId]             SMALLINT         CONSTRAINT [DF_CRE_RPI] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                   VARCHAR (MAX)    NULL,
    [EventDate]                      DATETIME         NULL,
    [EventTrueFalse]                 BIT              NULL,
    [DocumentationFolderLink]        VARCHAR (2000)   NULL,
    [JoinGUID]                       UNIQUEIDENTIFIER NOT NULL,
    [ComplaintEventCreationDate]     DATETIME         CONSTRAINT [DF_CRE_CECD] DEFAULT (getdate()) NOT NULL,
    [ComplaintEventLastModifiedDate] DATETIME         CONSTRAINT [DF_CRE_CELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME         CONSTRAINT [DF_CRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME         CONSTRAINT [DF_CRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)    CONSTRAINT [DF_CRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]          INT              CONSTRAINT [DF_CRE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]         ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]      DATETIME         CONSTRAINT [DF_CRE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKComplaintsRegisterEvents] PRIMARY KEY CLUSTERED ([ComplaintsRegisterEventId] ASC),
    CONSTRAINT [ComplaintsRegisterEventsComplaintEventTypeId] FOREIGN KEY ([ComplaintEventTypeId]) REFERENCES [Compliance].[ComplaintEventTypes] ([ComplaintEventTypeId]),
    CONSTRAINT [ComplaintsRegisterEventsComplaintRegisterId] FOREIGN KEY ([ComplaintRegisterId]) REFERENCES [Compliance].[ComplaintsRegister] ([ComplaintRegisterId]),
    CONSTRAINT [ComplaintsRegisterEventsRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

