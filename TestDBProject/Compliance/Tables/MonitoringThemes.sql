CREATE TABLE [Compliance].[MonitoringThemes] (
    [MonitoringThemeId]               INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringCategoryId]            INT              NOT NULL,
    [ThemeName]                       VARCHAR (128)    NOT NULL,
    [ThemeSummary]                    VARCHAR (MAX)    NULL,
    [SubmittedByPersonId]             SMALLINT         CONSTRAINT [DF_MT_MTSP] DEFAULT ((-1)) NOT NULL,
    [JoinGUID]                        UNIQUEIDENTIFIER CONSTRAINT [DF_MT_MTJG] DEFAULT (newid()) NOT NULL,
    [MonitoringThemeCreationDate]     DATETIME         CONSTRAINT [DF_MT_MTCDT] DEFAULT (getdate()) NOT NULL,
    [MonitoringThemeLastModifiedDate] DATETIME         CONSTRAINT [DF_MT_SLRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME         CONSTRAINT [DF_MT_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME         CONSTRAINT [DF_MT_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)    CONSTRAINT [DF_MT_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT              CONSTRAINT [DF_MT_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]          ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]       DATETIME         CONSTRAINT [DF_MT_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKMonitoringThemes] PRIMARY KEY CLUSTERED ([MonitoringThemeId] ASC),
    CONSTRAINT [MonitoringThemesMonitoringCategoryId] FOREIGN KEY ([MonitoringCategoryId]) REFERENCES [Compliance].[MonitoringCategories] ([MonitoringCategoryId])
);

