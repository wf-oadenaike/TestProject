﻿CREATE TABLE [Sales].[ClientTakeOnRegister] (
    [ClientTakeOnId]                           INT              IDENTITY (1, 1) NOT NULL,
    [ClientTakeOnName]                         VARCHAR (255)    NOT NULL,
    [ClientId]                                 INT              NOT NULL,
    [LatestTasks]                              VARCHAR (128)    NULL,
    [LatestApproval]                           VARCHAR (128)    NULL,
    [RFPId]                                    INT              NULL,
    [RelationshipManagerId]                    SMALLINT         NULL,
    [ProjectId]                                INT              NULL,
    [Status]                                   VARCHAR (50)     NULL,
    [MandateTypeId]                            SMALLINT         NULL,
    [InvestmentTeamPersonId]                   SMALLINT         NULL,
    [HeadofSalesPersonId]                      SMALLINT         NULL,
    [ProjectManagerPersonId]                   SMALLINT         NULL,
    [JiraLabel]                                VARCHAR (50)     NULL,
    [JiraEpicKey]                              VARCHAR (128)    NULL,
    [RecordedByPersonId]                       SMALLINT         CONSTRAINT [DF_CTOR_CTORRP] DEFAULT ((-1)) NOT NULL,
    [DocumentationFolderLink]                  VARCHAR (2000)   NULL,
    [JoinGUID]                                 UNIQUEIDENTIFIER NOT NULL,
    [ClientTakeOnRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_CTOR_CTORCDT] DEFAULT (getdate()) NOT NULL,
    [ClientTakeOnRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CTOR_CTORLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                    DATETIME         CONSTRAINT [DF_CTOR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                     DATETIME         CONSTRAINT [DF_CTOR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                   NVARCHAR (50)    CONSTRAINT [DF_CTOR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                    INT              CONSTRAINT [DF_CTOR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                   ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                DATETIME         CONSTRAINT [DF_CTOR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKClientTakeOnRegister] PRIMARY KEY CLUSTERED ([ClientTakeOnId] ASC),
    CONSTRAINT [ClientTakeOnRegisterClientId] FOREIGN KEY ([ClientId]) REFERENCES [Sales].[ClientRegister] ([ClientId]),
    CONSTRAINT [ClientTakeOnRegisterHeadofSalesPersonId] FOREIGN KEY ([HeadofSalesPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ClientTakeOnRegisterInvestmentTeamPersonId] FOREIGN KEY ([InvestmentTeamPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ClientTakeOnRegisterMandateTypeId] FOREIGN KEY ([MandateTypeId]) REFERENCES [Sales].[MandateTypes] ([MandateTypeId]),
    CONSTRAINT [ClientTakeOnRegisterProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [Organisation].[NewProjectsRegister] ([ProjectId]),
    CONSTRAINT [ClientTakeOnRegisterProjectManagerPersonId] FOREIGN KEY ([ProjectManagerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ClientTakeOnRegisterRecordedByPersonId] FOREIGN KEY ([RecordedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ClientTakeOnRegisterRelationshipManagerId] FOREIGN KEY ([RelationshipManagerId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ClientTakeOnRegisterRFPId] FOREIGN KEY ([RFPId]) REFERENCES [Sales].[RFPRegister] ([RFPId])
);

