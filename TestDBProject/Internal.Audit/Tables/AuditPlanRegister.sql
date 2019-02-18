CREATE TABLE [Internal.Audit].[AuditPlanRegister] (
    [AuditPlanRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [AuditNameBK]                   VARCHAR (128)    NOT NULL,
    [AuditType]                     VARCHAR (100)    NOT NULL,
    [AuditCreationDate]             DATETIME         CONSTRAINT [DF_APR_ACD] DEFAULT (getdate()) NOT NULL,
    [AuditYear]                     SMALLINT         NOT NULL,
    [AuditPlanStatus]               VARCHAR (128)    NOT NULL,
    [OwnerPersonId]                 SMALLINT         NOT NULL,
    [OwnerRoleId]                   SMALLINT         NOT NULL,
    [ProcessCoverage]               VARCHAR (2048)   NOT NULL,
    [AuditRationale]                VARCHAR (2048)   NOT NULL,
    [EstimatedDuration]             INT              NOT NULL,
    [ExpectedStartDate]             DATE             NOT NULL,
    [AuditFindings]                 VARCHAR (2048)   NULL,
    [AuditRecommendations]          VARCHAR (2048)   NULL,
    [AuditActions]                  VARCHAR (2048)   NULL,
    [EscalationYesNo]               BIT              NULL,
    [JIRAEpicKey]                   VARCHAR (2000)   NULL,
    [DocumentationFolderLink]       VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]           UNIQUEIDENTIFIER NOT NULL,
    [JoinGUID]                      UNIQUEIDENTIFIER NOT NULL,
    [AuditPlanCreationDatetime]     DATETIME         CONSTRAINT [DF_APR_APCDT] DEFAULT (getdate()) NOT NULL,
    [AuditPlanLastModifiedDatetime] DATETIME         CONSTRAINT [DF_APR_APLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKAuditPlanRegister] PRIMARY KEY CLUSTERED ([AuditNameBK] ASC),
    CONSTRAINT [AuditPlanRegisterOwnerPersonId] FOREIGN KEY ([OwnerPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [AuditPlanRegisterOwnerRoleId] FOREIGN KEY ([OwnerRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIAuditPlanRegister]
    ON [Internal.Audit].[AuditPlanRegister]([AuditPlanRegisterId] ASC);

