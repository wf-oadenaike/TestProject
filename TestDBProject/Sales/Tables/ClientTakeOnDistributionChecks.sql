CREATE TABLE [Sales].[ClientTakeOnDistributionChecks] (
    [ClientTakeOnId]                                    INT              NOT NULL,
    [IMADocumentationFolderLink]                        VARCHAR (2000)   NULL,
    [IMABoxFolderId]                                    VARCHAR (2000)   NULL,
    [ClientFileFolderLink]                              VARCHAR (2000)   NULL,
    [ReportingFrequency]                                VARCHAR (50)     NULL,
    [RecordedByPersonId]                                SMALLINT         CONSTRAINT [DF_CTODC_CTODCRP] DEFAULT ((-1)) NOT NULL,
    [DocumentationFolderLink]                           VARCHAR (2000)   NULL,
    [JoinGUID]                                          UNIQUEIDENTIFIER NOT NULL,
    [ClientTakeOnDistributionCheckCreationDatetime]     DATETIME         CONSTRAINT [DF_CTODC_CTODCCDT] DEFAULT (getdate()) NOT NULL,
    [ClientTakeOnDistributionCheckLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CTODC_CTODCLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                             DATETIME         CONSTRAINT [DF_CTODC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                              DATETIME         CONSTRAINT [DF_CTODC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                            NVARCHAR (50)    CONSTRAINT [DF_CTODC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                             INT              CONSTRAINT [DF_CTODC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                            ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                         DATETIME         CONSTRAINT [DF_CTODC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKClientTakeOnDistributionChecks] PRIMARY KEY CLUSTERED ([ClientTakeOnId] ASC),
    CONSTRAINT [ClientTakeOnDistributionCheckClientTakeOnId] FOREIGN KEY ([ClientTakeOnId]) REFERENCES [Sales].[ClientTakeOnRegister] ([ClientTakeOnId]),
    CONSTRAINT [ClientTakeOnDistributionCheckRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

