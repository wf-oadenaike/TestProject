CREATE TABLE [Staging].[KPIMetaData] (
    [KPIMetaDataId]  SMALLINT        IDENTITY (1, 1) NOT NULL,
    [KPIIDBK]        INT             NOT NULL,
    [IsPercentage]   BIT             NOT NULL,
    [Frequency]      VARCHAR (255)   NOT NULL,
    [KPIName]        VARCHAR (255)   NOT NULL,
    [KPIDescription] VARCHAR (255)   NULL,
    [TargetValue]    DECIMAL (19, 5) NULL,
    [ValueDirection] CHAR (1)        NOT NULL,
    [AggrFunction]   VARCHAR (3)     NOT NULL,
    [SortOrder]      INT             NOT NULL,
    [IsActive]       BIT             NOT NULL,
    [IsCalculated]   BIT             NULL,
    [CreatedAt]      VARCHAR (255)   NULL,
    [UpdatedAt]      VARCHAR (255)   NULL,
    CONSTRAINT [PKKPIMetaData] PRIMARY KEY CLUSTERED ([KPIIDBK] ASC)
);

