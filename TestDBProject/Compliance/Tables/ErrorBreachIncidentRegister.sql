CREATE TABLE [Compliance].[ErrorBreachIncidentRegister] (
    [EBIRegisterIdBK]              INT              IDENTITY (1, 1) NOT NULL,
    [EBIExternalReference]         VARCHAR (100)    NOT NULL,
    [ReportedByPersonId]           SMALLINT         NOT NULL,
    [ReportedBy]                   VARCHAR (128)    NOT NULL,
    [RecordedByPersonId]           SMALLINT         NOT NULL,
    [EBITypeCode]                  VARCHAR (25)     NOT NULL,
    [EBICategorisation]            VARCHAR (25)     NULL,
    [EBISummary]                   VARCHAR (2048)   NOT NULL,
    [ExternalNotificationRequired] BIT              NULL,
    [DateIdentified]               DATETIME         NOT NULL,
    [DocumentationFolderLink]      VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]          UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                     UNIQUEIDENTIFIER NOT NULL,
    [EBICreationDate]              DATETIME         CONSTRAINT [DF_EBIR_EBICD] DEFAULT (getdate()) NOT NULL,
    [EBILastModifiedDate]          DATETIME         CONSTRAINT [DF_EBIR_EBILMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKErrorBreachIncidentRegister] PRIMARY KEY CLUSTERED ([EBIRegisterIdBK] ASC),
    CONSTRAINT [ErrorBreachIncidentRegisterRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ErrorBreachIncidentRegisterReportedByPersonId] FOREIGN KEY ([ReportedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUErrorBreachIncidentRegisterJoinGUID]
    ON [Compliance].[ErrorBreachIncidentRegister]([JoinGUID] ASC);

