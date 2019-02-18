CREATE TABLE [ChangeManagement].[ChangeManagementEvents] (
    [ChangeManagementEventID]                   INT              IDENTITY (1, 1) NOT NULL,
    [ChangeManagementID]                        INT              NOT NULL,
    [ChangeManagementEventTypeID]               SMALLINT         NOT NULL,
    [SubmittedByPersonID]                       SMALLINT         CONSTRAINT [DF_CME_CMESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                              VARCHAR (MAX)    NULL,
    [EventDate]                                 DATETIME         NULL,
    [EventTrueFalse]                            BIT              NULL,
    [DocumentationFolderLink]                   VARCHAR (2000)   NULL,
    [JoinGUID]                                  UNIQUEIDENTIFIER NOT NULL,
    [ChangeManagementEventCreationDatetime]     DATETIME         CONSTRAINT [DF_CME_CMECD] DEFAULT (getdate()) NOT NULL,
    [ChangeManagementEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CME_CMELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                     DATETIME         CONSTRAINT [DF_CME_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                      DATETIME         CONSTRAINT [DF_CME_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                    NVARCHAR (50)    CONSTRAINT [DF_CME_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                     INT              CONSTRAINT [DF_CME_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                 DATETIME         CONSTRAINT [DF_CME_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKChangeManagementEvents] PRIMARY KEY CLUSTERED ([ChangeManagementEventID] ASC),
    CONSTRAINT [ChangeManagementEventsChangeManagementEventTypeID] FOREIGN KEY ([ChangeManagementEventTypeID]) REFERENCES [ChangeManagement].[ChangeManagementEventTypes] ([ChangeManagementEventTypeId]),
    CONSTRAINT [ChangeManagementEventsChangeManagementID] FOREIGN KEY ([ChangeManagementID]) REFERENCES [ChangeManagement].[ChangeManagementRegister] ([ChangeID]),
    CONSTRAINT [ChangeManagementEventsSubmittedByPersonID] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

