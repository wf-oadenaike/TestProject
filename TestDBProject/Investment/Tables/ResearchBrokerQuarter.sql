CREATE TABLE [Investment].[ResearchBrokerQuarter] (
    [QuarterId]                 SMALLINT         IDENTITY (1, 1) NOT NULL,
    [QuarterEndingName]         NVARCHAR (15)    NOT NULL,
    [ReviewTaskJiraKey]         NVARCHAR (255)   NULL,
    [DocusignTaskJiraKey]       NVARCHAR (255)   NULL,
    [SendLetterTaskJiraKey]     NVARCHAR (255)   NULL,
    [UploadInvoiceTaskJiraKey]  NVARCHAR (255)   NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         NULL
);

