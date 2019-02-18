CREATE TABLE [Organisation].[CriticalUserDefinedToolsRegister_OLD] (
    [ToolId]                  SMALLINT         IDENTITY (1, 1) NOT NULL,
    [ToolName]                NVARCHAR (255)   NOT NULL,
    [ToolPurpose]             NVARCHAR (MAX)   NOT NULL,
    [ToolOwnerId]             SMALLINT         NOT NULL,
    [StatusId]                INT              NOT NULL,
    [LastReviewDate]          DATETIME         NULL,
    [NextReviewDate]          DATETIME         NULL,
    [TargetRetirementDate]    DATETIME         NULL,
    [ToolLink]                NVARCHAR (255)   NULL,
    [IncludedInBIAAssessment] BIT              NOT NULL,
    [JIRAIssueKey]            NVARCHAR (255)   NULL,
    [JoinGUID]                UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50)    NULL
);

