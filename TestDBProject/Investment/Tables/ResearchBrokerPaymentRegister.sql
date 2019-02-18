CREATE TABLE [Investment].[ResearchBrokerPaymentRegister] (
    [ResearchBrokerPaymentId]   INT              IDENTITY (1, 1) NOT NULL,
    [ResearchBrokerId]          INT              NOT NULL,
    [StatusId]                  SMALLINT         NOT NULL,
    [QuarterId]                 SMALLINT         NOT NULL,
    [QuarterBudget]             DECIMAL (19, 2)  NOT NULL,
    [BrokerLetterSentDate]      DATETIME         NULL,
    [InvoicedAmount]            DECIMAL (19, 2)  NULL,
    [InvoiceSentDate]           DATETIME         NULL,
    [PaidAmount]                DECIMAL (19, 2)  NULL,
    [PaymentDate]               DATETIME         NULL,
    [SubmittedByPersonId]       SMALLINT         NOT NULL,
    [DocumentationFolderLink]   NVARCHAR (255)   NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         NULL
);

