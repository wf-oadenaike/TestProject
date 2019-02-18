CREATE TABLE [Staging].[QG_CompetitorAnalysis] (
    [KPIDate]      INT           NOT NULL,
    [QueryName]    VARCHAR (50)  NOT NULL,
    [QueryID]      INT           NOT NULL,
    [MentionCount] INT           NULL,
    [CreatedAt]    VARCHAR (255) NULL,
    [UpdatedAt]    VARCHAR (255) NULL,
    [KPIIDBK]      INT           NULL
);

