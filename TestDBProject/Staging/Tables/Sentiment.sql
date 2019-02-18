CREATE TABLE [Staging].[Sentiment] (
    [KPIDate]        INT           NOT NULL,
    [SentimentName]  VARCHAR (50)  NOT NULL,
    [SentimentCount] INT           NOT NULL,
    [KPIIDBK]        INT           NULL,
    [CreatedAt]      VARCHAR (255) NULL,
    [UpdatedAt]      VARCHAR (255) NULL
);

