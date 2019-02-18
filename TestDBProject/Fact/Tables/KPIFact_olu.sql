CREATE TABLE [Fact].[KPIFact_olu] (
    [KPIFactId]                 INT              IDENTITY (1, 1) NOT NULL,
    [MeasureDateId]             INT              NOT NULL,
    [KPIId]                     SMALLINT         NOT NULL,
    [MeasureValue]              DECIMAL (19, 5)  NOT NULL,
    [LastUpdatedDatetime]       DATETIME         CONSTRAINT [DF_KF_LUDT2] DEFAULT (getdate()) NOT NULL,
    [ControlId]                 BIGINT           NOT NULL,
    [SourceSystemId]            SMALLINT         NOT NULL,
    [RecordedBy]                NVARCHAR (128)   NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_KF_CSI2] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_KF_CSU2] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_KF_CSCB2] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_KF_CSP2] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_KF_CSL2] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKKPIFact2] PRIMARY KEY CLUSTERED ([KPIFactId] DESC) WITH (FILLFACTOR = 80),
    CONSTRAINT [KPIFactKPIId2] FOREIGN KEY ([KPIId]) REFERENCES [KPI].[MeasuredKPIs-old] ([KPIId]),
    CONSTRAINT [KPIFactMeasureDateId2] FOREIGN KEY ([MeasureDateId]) REFERENCES [Core].[Calendar] ([CalendarId]),
    CONSTRAINT [KPIFactSourceSystemId2] FOREIGN KEY ([SourceSystemId]) REFERENCES [Audit].[SourceSystems] ([SourceSystemId])
);


GO
ALTER TABLE [Fact].[KPIFact_olu] NOCHECK CONSTRAINT [KPIFactKPIId2];

