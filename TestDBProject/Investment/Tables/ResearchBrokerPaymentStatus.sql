CREATE TABLE [Investment].[ResearchBrokerPaymentStatus] (
    [StatusId]                  SMALLINT       IDENTITY (1, 1) NOT NULL,
    [StatusName]                NVARCHAR (255) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       NULL
);

