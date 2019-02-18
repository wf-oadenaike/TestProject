CREATE TABLE [Risk].[RiskAppetiteKRIRegister] (
    [RiskAppetiteKRIRegisterId]   INT              IDENTITY (1, 1) NOT NULL,
    [RiskOwnerId]                 SMALLINT         NOT NULL,
    [KPIID]                       SMALLINT         NOT NULL,
    [StatusID]                    SMALLINT         NOT NULL,
    [ProposedGreenThresholdValue] DECIMAL (19, 5)  NULL,
    [ProposedAmberThresholdValue] DECIMAL (19, 5)  NULL,
    [ProposedRedThresholdValue]   DECIMAL (19, 5)  NULL,
    [ProposedTargetValue]         DECIMAL (19, 5)  NULL,
    [SubmittedByPersonId]         SMALLINT         NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [LastModifiedDate]            DATETIME         NOT NULL,
    [JiraIssueKey]                NVARCHAR (50)    NULL,
    [IsActive]                    BIT              NULL,
    [JoinGUID]                    UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)    NULL,
    [IndividualReview]            BIT              DEFAULT ((0)) NOT NULL,
    [SubCategoryId]               SMALLINT         DEFAULT ((1)) NOT NULL,
    [CurrentGreenThresholdValue]  DECIMAL (19, 5)  NULL,
    [CurrentRedThresholdValue]    DECIMAL (19, 5)  NULL,
    [CurrentAmberThresholdValue]  DECIMAL (19, 5)  NULL,
    [CurrentTargetValue]          DECIMAL (19, 5)  NULL,
    CONSTRAINT [PKRiskAppetiteKRIRegister] PRIMARY KEY CLUSTERED ([RiskAppetiteKRIRegisterId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [RAKR_SubCategoryID] FOREIGN KEY ([SubCategoryId]) REFERENCES [Risk].[SubCategories] ([SubCategoryId]),
    CONSTRAINT [RAKRKPIID] FOREIGN KEY ([KPIID]) REFERENCES [KPI].[MeasuredKPIs-old] ([KPIId]),
    CONSTRAINT [RAKRRiskOwnerId] FOREIGN KEY ([RiskOwnerId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RAKRSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
ALTER TABLE [Risk].[RiskAppetiteKRIRegister] NOCHECK CONSTRAINT [RAKRKPIID];

