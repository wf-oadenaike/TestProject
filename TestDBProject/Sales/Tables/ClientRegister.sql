CREATE TABLE [Sales].[ClientRegister] (
    [ClientId]                           INT              IDENTITY (1, 1) NOT NULL,
    [ClientName]                         VARCHAR (50)     NOT NULL,
    [RelationshipManagerId]              SMALLINT         NULL,
    [AccountSalesforceId]                VARCHAR (18)     NULL,
    [PrimaryContactName]                 VARCHAR (50)     NULL,
    [ContactSalesforceId]                VARCHAR (18)     NULL,
    [IsActive]                           BIT              CONSTRAINT [DF_CR_CRIA] DEFAULT ((0)) NOT NULL,
    [RecordedByPersonId]                 SMALLINT         CONSTRAINT [DF_CR_CRRP] DEFAULT ((-1)) NOT NULL,
    [BillingFrequency]                   VARCHAR (128)    NULL,
    [FrequencyStartMonth]                VARCHAR (25)     NULL,
    [ReconciliationEmailAddress]         VARCHAR (256)    NULL,
    [DocumentationFolderLink]            VARCHAR (2000)   NULL,
    [JoinGUID]                           UNIQUEIDENTIFIER NOT NULL,
    [ClientRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_CR_CRCDT] DEFAULT (getdate()) NOT NULL,
    [ClientRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CR_CRLMDT] DEFAULT (getdate()) NOT NULL,
    [BoxFolderID]                        VARCHAR (25)     NULL,
    CONSTRAINT [PKClientRegister] PRIMARY KEY CLUSTERED ([ClientId] ASC),
    CONSTRAINT [ClientRegisterRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ClientRegisterRelationshipManagerId] FOREIGN KEY ([RelationshipManagerId]) REFERENCES [Core].[Persons] ([PersonId])
);

