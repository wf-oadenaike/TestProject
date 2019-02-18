﻿CREATE TABLE [Organisation].[BrokerOnBoardingRegister] (
    [BrokerOnBoardingRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [ContactName]                          VARCHAR (128)    NULL,
    [ContactSalesforceIdBK]                VARCHAR (18)     NULL,
    [ExecutionAccountSalesforceId]         VARCHAR (18)     NULL,
    [BrokerCompanyName]                    VARCHAR (128)    NOT NULL,
    [ContactEmailAddress]                  VARCHAR (256)    NULL,
    [BrokerOnBoardingDetails]              VARCHAR (2048)   NULL,
    [ProposerPersonId]                     SMALLINT         NOT NULL,
    [BrokerOnBoardingStatus]               VARCHAR (128)    NOT NULL,
    [OneTimeUse]                           BIT              CONSTRAINT [DF_BOBR_OTU] DEFAULT ((0)) NOT NULL,
    [ProposalDate]                         DATETIME         NULL,
    [ApprovalDate]                         DATETIME         NULL,
    [MeetingJIRAEpicKey]                   VARCHAR (2000)   NULL,
    [BERCMeetingRegisterId]                SMALLINT         NULL,
    [BERCMeetingDateTime]                  DATETIME         NULL,
    [BloombergId]                          VARCHAR (25)     NULL,
    [MasterBloombergId]                    VARCHAR (25)     NULL,
    [BrokerServiceTypeId]                  INT              NULL,
    [JIRAEpicKey]                          VARCHAR (2000)   NULL,
    [NewBrokerJIRAIssueKey]                VARCHAR (2000)   NULL,
    [NewMasterBroker]                      BIT              NULL,
    [ExpectedDateUse]                      DATETIME         NULL,
    [RelationshipOwnerId]                  SMALLINT         NULL,
    [DocumentationFolderLink]              VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]                  UNIQUEIDENTIFIER NULL,
    [JoinGUID]                             UNIQUEIDENTIFIER NOT NULL,
    [BrokerOnBoardingCreationDatetime]     DATETIME         CONSTRAINT [DF_BOBR_BOBCDT] DEFAULT (getdate()) NOT NULL,
    [BrokerOnBoardingLastModifiedDatetime] DATETIME         CONSTRAINT [DF_BOBR_BOBLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKBrokerOnBoardingRegister] PRIMARY KEY CLUSTERED ([BrokerOnBoardingRegisterId] ASC),
    CONSTRAINT [BrokerOnBoardingRegisterBrokerServiceTypeId] FOREIGN KEY ([BrokerServiceTypeId]) REFERENCES [Organisation].[BrokerServiceTypes] ([ServiceTypeId]),
    CONSTRAINT [BrokerOnBoardingRegisterProposerPersonId] FOREIGN KEY ([ProposerPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);
