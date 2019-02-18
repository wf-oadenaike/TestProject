CREATE TABLE [Sales].[ClientReporting] (
    [ClientReportingId]                   INT              IDENTITY (1, 1) NOT NULL,
    [MandateId]                           INT              NOT NULL,
    [ReportName]                          VARCHAR (128)    NOT NULL,
    [ReportType]                          VARCHAR (128)    NOT NULL,
    [ReportingFrequency]                  VARCHAR (128)    NOT NULL,
    [FrequencyStartDay]                   INT              NULL,
    [FrequencyStartMonth]                 VARCHAR (25)     NULL,
    [DeadlineDaysOffset]                  SMALLINT         NULL,
    [Notes]                               VARCHAR (MAX)    NULL,
    [SubmittedByPersonId]                 SMALLINT         CONSTRAINT [DF_CLR_CLRSP] DEFAULT ((-1)) NOT NULL,
    [DocumentationFolderLink]             VARCHAR (2000)   NULL,
    [JoinGUID]                            UNIQUEIDENTIFIER NOT NULL,
    [ClientReportingCreationDatetime]     DATETIME         CONSTRAINT [DF_CLR_CLRCDT] DEFAULT (getdate()) NOT NULL,
    [ClientReportingLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CLR_CLRLMDT] DEFAULT (getdate()) NOT NULL,
    [IsActive]                            BIT              CONSTRAINT [DF_WLL_IA] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PKClientReporting] PRIMARY KEY CLUSTERED ([ClientReportingId] ASC),
    CONSTRAINT [ClientReportingMandateId] FOREIGN KEY ([MandateId]) REFERENCES [Investment].[Mandates] ([MandateId]),
    CONSTRAINT [ClientReportingSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

