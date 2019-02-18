CREATE TABLE [Sales].[TrailCommissionEvents] (
    [TrailCommissionEventId]    INT              IDENTITY (1, 1) NOT NULL,
    [TrailCommissionId]         INT              NOT NULL,
    [EventDetails]              VARCHAR (MAX)    NOT NULL,
    [EventType]                 NVARCHAR (255)   NOT NULL,
    [SubmittedByPersonId]       SMALLINT         NOT NULL,
    [DocumentationFolderLink]   NVARCHAR (2000)  NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_TCE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_TCE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_TCE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_TCE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_TCE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTrailCommissionEventId] PRIMARY KEY CLUSTERED ([TrailCommissionEventId] ASC),
    CONSTRAINT [TrailCommissionEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [TrailCommissionEventsTrailCommissionId] FOREIGN KEY ([TrailCommissionId]) REFERENCES [Sales].[TrailCommissionRegister] ([TrailCommissionId])
);

