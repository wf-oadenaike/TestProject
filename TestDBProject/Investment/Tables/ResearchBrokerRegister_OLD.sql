CREATE TABLE [Investment].[ResearchBrokerRegister_OLD] (
    [ResearchBrokerId]                   INT              IDENTITY (1, 1) NOT NULL,
    [BrokerCompanyName]                  NVARCHAR (128)   NOT NULL,
    [BloombergId]                        VARCHAR (25)     NULL,
    [BrokerServiceTypeId]                INT              NOT NULL,
    [UnderCSAControl]                    BIT              NULL,
    [ServiceCost]                        DECIMAL (19, 2)  NULL,
    [ResearchCostWIMFundsPercent]        DECIMAL (5, 2)   NULL,
    [ResearchCostWIMLLPPercent]          DECIMAL (5, 2)   NULL,
    [PaymentFrequencyId]                 INT              NULL,
    [PaymentTerms]                       VARCHAR (25)     NULL,
    [ServiceDescription]                 NVARCHAR (MAX)   NULL,
    [InitialBudgetAmount]                DECIMAL (19, 2)  NULL,
    [InitialBudgetDate]                  DATETIME         NULL,
    [RecordedByPersonId]                 SMALLINT         NOT NULL,
    [BrokerRelationshipPersonId]         SMALLINT         NOT NULL,
    [ResearchAccountSalesforceId]        VARCHAR (18)     NULL,
    [DocumentationFolderLink]            VARCHAR (2000)   NULL,
    [JoinGUID]                           UNIQUEIDENTIFIER NOT NULL,
    [ResearchBrokerCreationDatetime]     DATETIME         NOT NULL,
    [ResearchBrokerLastModifiedDatetime] DATETIME         NOT NULL,
    CONSTRAINT [PKBrokerOnBoardingRegister] PRIMARY KEY CLUSTERED ([ResearchBrokerId] ASC)
);

