CREATE TABLE [Risk].[RiskRegisterEvents] (
    [RiskRegisterEventId]           INT              IDENTITY (1, 1) NOT NULL,
    [RiskRegisterId]                INT              NOT NULL,
    [RiskEventTypeID]               INT              NOT NULL,
    [RiskRegisterEventPersonId]     SMALLINT         NOT NULL,
    [RiskRegisterEventComment]      NVARCHAR (2000)  NULL,
    [RiskRegisterEventCreationDate] DATETIME         CONSTRAINT [DT_RR_RRECDT] DEFAULT (getdate()) NOT NULL,
    [WorkflowVersionGUID]           UNIQUEIDENTIFIER NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_RRE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_RRE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_RRE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_RRE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_RRE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKRiskRegisterEvents] PRIMARY KEY CLUSTERED ([RiskRegisterEventId] ASC),
    CONSTRAINT [RiskRegisterEventsRiskEventTypeID] FOREIGN KEY ([RiskEventTypeID]) REFERENCES [Risk].[RiskRegisterEventTypes] ([RiskEventTypeID]),
    CONSTRAINT [RiskRegisterEventsRiskPersonId] FOREIGN KEY ([RiskRegisterEventPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RiskRegisterEventsRiskRegisterId] FOREIGN KEY ([RiskRegisterId]) REFERENCES [Risk].[RiskRegister] ([RiskRegisterId])
);

