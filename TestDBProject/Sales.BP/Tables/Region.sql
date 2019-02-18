CREATE TABLE [Sales.BP].[Region] (
    [RegionId]                   INT             NOT NULL,
    [RegionName]                 NVARCHAR (128)  NOT NULL,
    [Description]                NVARCHAR (1000) NULL,
    [RegionalSalesManager]       NVARCHAR (128)  NULL,
    [SalesAccountManager]        NVARCHAR (128)  NULL,
    [SwGleq]                     DECIMAL (5, 2)  NULL,
    [SwRest]                     DECIMAL (5, 2)  NULL,
    [SwTsal]                     DECIMAL (5, 2)  NULL,
    [SwUkac]                     DECIMAL (5, 2)  NULL,
    [SwUkeb]                     DECIMAL (5, 2)  NULL,
    [SwUkei]                     DECIMAL (5, 2)  NULL,
    [TotalSectorWeightings]      DECIMAL (5, 2)  NULL,
    [AccountOwnerId]             VARCHAR (18)    NULL,
    [IsActive]                   BIT             NOT NULL,
    [RegionCreationDatetime]     DATETIME        CONSTRAINT [DF_REG_REGCDT] DEFAULT (getdate()) NOT NULL,
    [RegionLastModifiedDatetime] DATETIME        CONSTRAINT [DF_REG_REGLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKRegionId] PRIMARY KEY CLUSTERED ([RegionId] ASC)
);

