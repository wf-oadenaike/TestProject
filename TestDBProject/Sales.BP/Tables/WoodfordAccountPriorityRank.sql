CREATE TABLE [Sales.BP].[WoodfordAccountPriorityRank] (
    [Id]              INT             IDENTITY (1, 1) NOT NULL,
    [AccSalesforceId] CHAR (18)       NOT NULL,
    [AccName]         NVARCHAR (MAX)  NOT NULL,
    [AccFcaId]        INT             NOT NULL,
    [AccPostcode]     NVARCHAR (20)   NOT NULL,
    [AccOwnerId]      NVARCHAR (100)  NOT NULL,
    [AccOwnerName]    NVARCHAR (100)  NULL,
    [PriorityRankOld] INT             NULL,
    [PriorityRankNew] INT             NULL,
    [MarketSales]     DECIMAL (19, 5) NULL,
    CONSTRAINT [pk_wapr_id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

