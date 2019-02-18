CREATE TABLE [Fact].[KPIFact] (
    [KPIFactId]                 INT              IDENTITY (1, 1) NOT NULL,
    [MeasureDateId]             INT              NOT NULL,
    [KPIId]                     SMALLINT         NOT NULL,
    [MeasureValue]              DECIMAL (19, 5)  NOT NULL,
    [LastUpdatedDatetime]       DATETIME         CONSTRAINT [DF_KF_LUDT] DEFAULT (getdate()) NOT NULL,
    [ControlId]                 BIGINT           NOT NULL,
    [SourceSystemId]            SMALLINT         NOT NULL,
    [RecordedBy]                NVARCHAR (128)   NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_KF_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_KF_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_KF_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_KF_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_KF_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKKPIFact] PRIMARY KEY NONCLUSTERED ([KPIFactId] DESC) WITH (FILLFACTOR = 80),
    CONSTRAINT [KPIFactMeasureDateId] FOREIGN KEY ([MeasureDateId]) REFERENCES [Core].[Calendar] ([CalendarId]),
    CONSTRAINT [KPIFactSourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [Audit].[SourceSystems] ([SourceSystemId])
);


GO
CREATE CLUSTERED INDEX [NDX_KPIID_MEASUREDATEID]
    ON [Fact].[KPIFact]([KPIId] ASC, [MeasureDateId] DESC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIKPIFact]
    ON [Fact].[KPIFact]([KPIId] ASC, [MeasureDateId] DESC, [LastUpdatedDatetime] DESC) WITH (FILLFACTOR = 80);

