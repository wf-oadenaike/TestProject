﻿CREATE TABLE [Organisation].[NewProjectsRegister] (
    [ProjectId]                               INT              IDENTITY (1, 1) NOT NULL,
    [ProjectName]                             VARCHAR (100)    NOT NULL,
    [RequestorPersonId]                       SMALLINT         CONSTRAINT [DF_NPR_NPRRP] DEFAULT ((-1)) NOT NULL,
    [OwnerPersonId]                           SMALLINT         NULL,
    [OversightPersonId]                       SMALLINT         NULL,
    [ProposedStartDate]                       DATETIME         NULL,
    [EstimatedDuration]                       VARCHAR (50)     NULL,
    [EstimatedCost]                           DECIMAL (19, 2)  NULL,
    [TechnologyInvolvedYesNo]                 BIT              NULL,
    [ProjectStatus]                           VARCHAR (100)    NULL,
    [ProjectType]                             VARCHAR (100)    NULL,
    [ProjectPurpose]                          VARCHAR (MAX)    NULL,
    [ProjectScope]                            VARCHAR (MAX)    NULL,
    [Dependences]                             VARCHAR (MAX)    NULL,
    [ExternalResources]                       VARCHAR (MAX)    NULL,
    [DepartmentId]                            SMALLINT         NULL,
    [NewResourcesYesNo]                       BIT              NULL,
    [NewTechnology]                           VARCHAR (MAX)    NULL,
    [AdditionalDetails]                       VARCHAR (MAX)    NULL,
    [JiraEpicKey]                             VARCHAR (128)    NULL,
    [DueDate]                                 DATETIME         NULL,
    [CreateNewEpic]                           BIT              NULL,
    [IsClientTakeOn]                          BIT              NULL,
    [RAGStatus]                               VARCHAR (20)     NULL,
    [ActualStartDate]                         DATE             NULL,
    [ActualEndDate]                           DATE             NULL,
    [NewResourceNumber]                       INT              NULL,
    [NewResourceCost]                         DECIMAL (19, 2)  NULL,
    [ITResourceYesNo]                         BIT              CONSTRAINT [DF_NPR_NPRITRYN] DEFAULT ((0)) NOT NULL,
    [ITResourceNumber]                        INT              NULL,
    [ITResourceCost]                          DECIMAL (19, 2)  NULL,
    [OtherCostYesNo]                          BIT              CONSTRAINT [DF_NPR_NPROCYN] DEFAULT ((0)) NOT NULL,
    [OtherCost]                               DECIMAL (19, 2)  NULL,
    [Rescoped]                                BIT              CONSTRAINT [DF_NPR_NPRR] DEFAULT ((0)) NOT NULL,
    [InternalAudit]                           BIT              CONSTRAINT [DF_NPR_NPRIA] DEFAULT ((0)) NOT NULL,
    [ExternalComms]                           BIT              CONSTRAINT [DF_NPR_NPREC] DEFAULT ((0)) NOT NULL,
    [ProjectBillingCode]                      VARCHAR (20)     NULL,
    [NewResourceDetails]                      VARCHAR (MAX)    NULL,
    [ITResourceDetails]                       VARCHAR (MAX)    NULL,
    [NewTechnologyCost]                       DECIMAL (19, 2)  NULL,
    [PreviousProjectId]                       INT              NULL,
    [LegalCostYesNo]                          BIT              CONSTRAINT [DF_NPR_NPRLCYN] DEFAULT ((0)) NOT NULL,
    [LegalCosts]                              DECIMAL (19, 2)  NULL,
    [LegalCostDetails]                        VARCHAR (MAX)    NULL,
    [DocumentationFolderLink]                 VARCHAR (2000)   NULL,
    [JoinGUID]                                UNIQUEIDENTIFIER NOT NULL,
    [NewProjectsRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_NPR_NPRCDT] DEFAULT (getdate()) NOT NULL,
    [NewProjectsRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_NPR_NPRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                   DATETIME         CONSTRAINT [DF_NPR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                    DATETIME         CONSTRAINT [DF_NPR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                  NVARCHAR (50)    CONSTRAINT [DF_NPR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                   INT              CONSTRAINT [DF_NPR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                  ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]               DATETIME         CONSTRAINT [DF_NPR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKNewProjectsRegister] PRIMARY KEY CLUSTERED ([ProjectId] ASC),
    CONSTRAINT [NewProjectsRegisterDepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Core].[Departments] ([DepartmentId]),
    CONSTRAINT [NewProjectsRegisterOversightPersonId] FOREIGN KEY ([OversightPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [NewProjectsRegisterOwnerPersonId] FOREIGN KEY ([OwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [NewProjectsRegisterRequestorPersonId] FOREIGN KEY ([RequestorPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);
