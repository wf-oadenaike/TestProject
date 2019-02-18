CREATE TABLE [Organisation].[BrokerAttestationEvents] (
    [BrokerAttestationEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [BrokerAttestationId]                        INT              NOT NULL,
    [BrokerAttestationEventType]                 VARCHAR (100)    NOT NULL,
    [EventDetails]                               VARCHAR (MAX)    NULL,
    [EventDate]                                  DATETIME         NULL,
    [SubmittedByPersonId]                        SMALLINT         CONSTRAINT [DF_BAE_BAESP] DEFAULT ((-1)) NULL,
    [DocumentationFolderLink]                    VARCHAR (2000)   NULL,
    [JoinGUID]                                   UNIQUEIDENTIFIER NOT NULL,
    [BrokerAttestationEventCreationDatetime]     DATETIME         CONSTRAINT [DF_BAE_BAECD] DEFAULT (getdate()) NOT NULL,
    [BrokerAttestationEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_BAE_BAELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                      DATETIME         CONSTRAINT [DF_BAE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                       DATETIME         CONSTRAINT [DF_BAE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                     NVARCHAR (50)    CONSTRAINT [DF_BAE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                      INT              CONSTRAINT [DF_BAE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                     ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                  DATETIME         CONSTRAINT [DF_BAE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKBrokerAttestationEvents] PRIMARY KEY CLUSTERED ([BrokerAttestationEventId] ASC),
    CONSTRAINT [BrokerAttestationEventSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

