CREATE TABLE [KPI].[KPIBreachRegister] (
    [KPIBreachId]                   INT              IDENTITY (1, 1) NOT NULL,
    [KPIId]                         SMALLINT         NOT NULL,
    [KPIValue]                      DECIMAL (19, 5)  NULL,
    [ThresholdValue]                DECIMAL (19, 5)  NULL,
    [RAGName]                       VARCHAR (10)     NOT NULL,
    [BreachDate]                    DATETIME         NOT NULL,
    [FollowUpAction]                VARCHAR (MAX)    NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NULL,
    [KPIBreachCreationDatetime]     DATETIME         CONSTRAINT [DF_KBR_RRTCDT] DEFAULT (getdate()) NOT NULL,
    [KPIBreachLastModifiedDatetime] DATETIME         CONSTRAINT [DF_KBR_RRTLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_KBR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_KBR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_KBR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_KBR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_KBR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKKPIBreachRegister] PRIMARY KEY CLUSTERED ([KPIBreachId] ASC),
    CONSTRAINT [KPIBreachRegisterKPIId] FOREIGN KEY ([KPIId]) REFERENCES [KPI].[MeasuredKPIs-old] ([KPIId])
);


GO
ALTER TABLE [KPI].[KPIBreachRegister] NOCHECK CONSTRAINT [KPIBreachRegisterKPIId];

