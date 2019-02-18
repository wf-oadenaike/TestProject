CREATE TABLE [Compliance].[PADealingRequestRegister] (
    [PADealingRequestRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [RequestorPersonId]                    SMALLINT         NOT NULL,
    [RequestorRoleId]                      SMALLINT         NOT NULL,
    [RequestedDate]                        DATETIME         NOT NULL,
    [PADealingRequestStatus]               VARCHAR (128)    NOT NULL,
    [OnStopList]                           BIT              CONSTRAINT [DF_PADR_OSL] DEFAULT ((0)) NOT NULL,
    [InvestmentName]                       VARCHAR (128)    NOT NULL,
    [InvestmentType]                       VARCHAR (50)     NOT NULL,
    [PADealingTransactionTypeBK]           VARCHAR (25)     NOT NULL,
    [WoodfordInvestmentYesNo]              BIT              CONSTRAINT [DF_PADR_WIYN] DEFAULT ((0)) NOT NULL,
    [Value]                                DECIMAL (19, 2)  NULL,
    [EmployeeComments]                     VARCHAR (2048)   NULL,
    [ComplianceComments]                   VARCHAR (2048)   NULL,
    [ComplianceDecisionDate]               DATETIME         NULL,
    [CompliancePersonId]                   SMALLINT         NULL,
    [DocumentationFolderLink]              VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                             UNIQUEIDENTIFIER NOT NULL,
    [PADealingRequestCreationDatetime]     DATETIME         CONSTRAINT [DF_PADR_PADRCDT] DEFAULT (getdate()) NOT NULL,
    [PADealingRequestLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PADR_PADRLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKPADealingRequestRegister] PRIMARY KEY CLUSTERED ([PADealingRequestRegisterId] ASC),
    CONSTRAINT [PADealingRequestRegisterCompliancePersonId] FOREIGN KEY ([CompliancePersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [PADealingRequestRegisterRequestorPersonId] FOREIGN KEY ([RequestorPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [PADealingRequestRegisterRequestorRoleId] FOREIGN KEY ([RequestorRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIPADealingRequestRegister]
    ON [Compliance].[PADealingRequestRegister]([PADealingRequestRegisterId] ASC);

