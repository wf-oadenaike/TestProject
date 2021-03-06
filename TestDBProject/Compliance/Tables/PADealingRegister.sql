﻿CREATE TABLE [Compliance].[PADealingRegister] (
    [PADealingRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [RequestorPersonId]             SMALLINT         NOT NULL,
    [RequestedDate]                 DATETIME         NOT NULL,
    [Status]                        VARCHAR (128)    NOT NULL,
    [OnStopList]                    BIT              CONSTRAINT [DF_PADER_OSL] DEFAULT ((0)) NOT NULL,
    [BloombergId]                   VARCHAR (30)     NULL,
    [InvestmentName]                VARCHAR (128)    NULL,
    [InvestmentType]                VARCHAR (128)    NOT NULL,
    [TransactionType]               VARCHAR (25)     NOT NULL,
    [WoodfordInvestmentYesNo]       BIT              CONSTRAINT [DF_PADER_WIYN] DEFAULT ((0)) NOT NULL,
    [Value]                         DECIMAL (19, 2)  NULL,
    [CurrencyCode]                  CHAR (3)         CONSTRAINT [DF_PADER_CC] DEFAULT ('GBP') NOT NULL,
    [NumOfShares]                   INT              NULL,
    [SalaryPercentage]              DECIMAL (19, 2)  NULL,
    [EmployeeComments]              VARCHAR (MAX)    NULL,
    [ComplianceComments]            VARCHAR (MAX)    NULL,
    [ComplianceDecisionDate]        DATETIME         NULL,
    [CompliancePersonId]            SMALLINT         NULL,
    [WithdrawalRequestedYesNo]      BIT              CONSTRAINT [DF_PADER_WRYN] DEFAULT ((0)) NOT NULL,
    [JIRAIssueKey]                  VARCHAR (255)    NULL,
    [DocumentationFolderLink]       VARCHAR (2000)   NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [PADealingCreationDatetime]     DATETIME         CONSTRAINT [DF_PADER_PADRCDT] DEFAULT (getdate()) NOT NULL,
    [PADealingLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PADER_PADRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME         CONSTRAINT [DF_PADER_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME         CONSTRAINT [DF_PADER_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)    CONSTRAINT [DF_PADER_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT              CONSTRAINT [DF_PADER_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]        ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]     DATETIME         CONSTRAINT [DF_PADER_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPADealingRegister] PRIMARY KEY CLUSTERED ([PADealingRegisterId] ASC),
    CONSTRAINT [PADealingRegisterCompliancePersonId] FOREIGN KEY ([CompliancePersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [PADealingRegisterRequestorPersonId] FOREIGN KEY ([RequestorPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

