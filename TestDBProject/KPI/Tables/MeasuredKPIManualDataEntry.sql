CREATE TABLE [KPI].[MeasuredKPIManualDataEntry] (
    [KPIId]                     SMALLINT        NOT NULL,
    [DataEntryPersonId]         SMALLINT        NULL,
    [DataEntryFrequencyId]      SMALLINT        NOT NULL,
    [JiraProjectKey]            VARCHAR (128)   NULL,
    [JiraEpicKey]               VARCHAR (128)   NULL,
    [IsActive]                  BIT             CONSTRAINT [DF_MKPIMDE_IA] DEFAULT ((1)) NOT NULL,
    [DefaultValue]              DECIMAL (19, 5) NULL,
    [Notes]                     VARCHAR (1000)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF_MKPIMDE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF_MKPIMDE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF_MKPIMDE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF_MKPIMDE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF_MKPIMDE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKMeasuredKPIManualDataEntry] PRIMARY KEY CLUSTERED ([KPIId] ASC),
    CONSTRAINT [MeasuredKPIManualDataEntryDataEntryPersonId] FOREIGN KEY ([DataEntryPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [MeasuredKPIManualDataEntryFrequencyId] FOREIGN KEY ([DataEntryFrequencyId]) REFERENCES [KPI].[RefreshFrequency] ([RefreshFrequencyId])
);

