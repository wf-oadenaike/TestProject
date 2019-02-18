CREATE TABLE [Compliance].[MonitoringCategories] (
    [MonitoringCategoryId]               INT              IDENTITY (1, 1) NOT NULL,
    [MonitoringType]                     VARCHAR (128)    NOT NULL,
    [CategoryName]                       VARCHAR (128)    NOT NULL,
    [MonitoringFrequency]                VARCHAR (128)    NOT NULL,
    [FrequencyMonths]                    VARCHAR (128)    NULL,
    [FrequencyStartMonth]                VARCHAR (50)     NULL,
    [DueDateOffSet]                      SMALLINT         NULL,
    [DocumentationURL]                   VARCHAR (2000)   NULL,
    [SubmittedByPersonId]                SMALLINT         CONSTRAINT [DF_MC_MCSP] DEFAULT ((-1)) NOT NULL,
    [JoinGUID]                           UNIQUEIDENTIFIER CONSTRAINT [DF_MC_MCJG] DEFAULT (newid()) NOT NULL,
    [MonitoringCategoryCreationDate]     DATETIME         CONSTRAINT [DF_MC_MCCDT] DEFAULT (getdate()) NOT NULL,
    [MonitoringCategoryLastModifiedDate] DATETIME         CONSTRAINT [DF_MC_SLRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]              DATETIME         CONSTRAINT [DF_MC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]               DATETIME         CONSTRAINT [DF_MC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]             NVARCHAR (50)    CONSTRAINT [DF_MC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]              INT              CONSTRAINT [DF_MC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]             ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]          DATETIME         CONSTRAINT [DF_MC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKMonitoringCategories] PRIMARY KEY CLUSTERED ([MonitoringCategoryId] ASC)
);

