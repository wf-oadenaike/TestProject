CREATE TABLE [Risk].[RiskAppetiteRegister] (
    [RiskAppetiteRegisterId] INT              IDENTITY (1, 1) NOT NULL,
    [RiskOwnerId]            SMALLINT         NOT NULL,
    [SubCategoryID]          SMALLINT         NOT NULL,
    [ProposedRiskAppetite]   VARCHAR (10)     NULL,
    [StatusID]               INT              NOT NULL,
    [SubmittedByPersonId]    SMALLINT         NULL,
    [CreatedDate]            DATETIME         NOT NULL,
    [LastModifiedDate]       DATETIME         NOT NULL,
    [JiraIssueKey]           NVARCHAR (50)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [IndividualReview]       BIT              DEFAULT ((0)) NOT NULL,
    [CurrentRiskAppetite]    VARCHAR (10)     NULL,
    CONSTRAINT [PKRiskAppetiteRegister] PRIMARY KEY CLUSTERED ([RiskAppetiteRegisterId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [RARRiskOwnerId] FOREIGN KEY ([RiskOwnerId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [RARStatusID] FOREIGN KEY ([StatusID]) REFERENCES [Core].[FlowStatus] ([FlowStatusId]),
    CONSTRAINT [RARSubCategoryID] FOREIGN KEY ([SubCategoryID]) REFERENCES [Risk].[SubCategories] ([SubCategoryId]),
    CONSTRAINT [RARSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

