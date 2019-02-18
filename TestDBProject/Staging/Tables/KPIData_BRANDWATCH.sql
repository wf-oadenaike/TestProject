CREATE TABLE [Staging].[KPIData_BRANDWATCH] (
    [KPIIDBK]     INT             NOT NULL,
    [KPIDataDate] VARCHAR (255)   NOT NULL,
    [TargetValue] DECIMAL (19, 5) NULL,
    [ActualValue] DECIMAL (19, 5) NOT NULL,
    [Notes]       VARCHAR (255)   NULL,
    [CreatedAt]   VARCHAR (255)   NULL,
    [UpdatedAt]   VARCHAR (255)   NULL
);

