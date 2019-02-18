CREATE TABLE [Organisation].[AssetTypes] (
    [AssetTypeId]      INT           IDENTITY (1, 1) NOT NULL,
    [AssetType]        VARCHAR (128) NOT NULL,
    [AssetCode]        VARCHAR (50)  NULL,
    [DepreciationType] VARCHAR (50)  NOT NULL,
    [WritedownPeriod]  INT           CONSTRAINT [DF_AT_CWP] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PKAssetTypes] PRIMARY KEY CLUSTERED ([AssetTypeId] ASC)
);

