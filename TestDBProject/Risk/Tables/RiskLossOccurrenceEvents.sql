CREATE TABLE [Risk].[RiskLossOccurrenceEvents] (
    [LossOccurrenceEventId]     INT              IDENTITY (1, 1) NOT NULL,
    [LossOccurrenceId]          INT              NOT NULL,
    [EventDetails]              VARCHAR (MAX)    NOT NULL,
    [EventType]                 NVARCHAR (255)   NOT NULL,
    [EventDate]                 DATE             NULL,
    [IsActive]                  BIT              NOT NULL,
    [SubmittedByPersonId]       SMALLINT         NOT NULL,
    [DocumentationFolderLink]   NVARCHAR (2000)  NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_RLOE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_RLOE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_RLOE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_RLOE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_RLOE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRiskLossEventsEventId] PRIMARY KEY CLUSTERED ([LossOccurrenceEventId] ASC),
    CONSTRAINT [RiskLossOccurrenceEventsLossOccurrenceId] FOREIGN KEY ([LossOccurrenceId]) REFERENCES [Risk].[RiskLossOccurrence] ([LossOccurrenceId]),
    CONSTRAINT [RiskLossOccurrenceEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

