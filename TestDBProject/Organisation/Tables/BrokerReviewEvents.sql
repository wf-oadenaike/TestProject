CREATE TABLE [Organisation].[BrokerReviewEvents] (
    [BrokerReviewEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [BloombergId]                           VARCHAR (40)     NOT NULL,
    [BrokerReviewEventTypeId]               SMALLINT         NOT NULL,
    [SubmittedByPersonId]                   SMALLINT         CONSTRAINT [DF_BRE_BRESP] DEFAULT ((-1)) NOT NULL,
    [EventDetails]                          VARCHAR (MAX)    NULL,
    [EventDate]                             DATETIME         NULL,
    [EventTrueFalse]                        BIT              NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [BrokerReviewEventCreationDatetime]     DATETIME         CONSTRAINT [DF_BRE_BRECD] DEFAULT (getdate()) NOT NULL,
    [BrokerReviewEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_BRE_BRELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME         CONSTRAINT [DF_BRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME         CONSTRAINT [DF_BRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)    CONSTRAINT [DF_BRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT              CONSTRAINT [DF_BRE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME         CONSTRAINT [DF_BRE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKBrokerReviewEvents] PRIMARY KEY CLUSTERED ([BrokerReviewEventId] ASC),
    CONSTRAINT [BrokerReviewEventsEventTypeId] FOREIGN KEY ([BrokerReviewEventTypeId]) REFERENCES [Organisation].[BrokerReviewEventTypes] ([BrokerReviewEventTypeId]),
    CONSTRAINT [BrokerReviewEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

