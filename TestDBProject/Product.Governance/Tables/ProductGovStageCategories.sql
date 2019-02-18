CREATE TABLE [Product.Governance].[ProductGovStageCategories] (
    [StageCategoryId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [StageCategoryName] VARCHAR (128) NOT NULL,
    CONSTRAINT [PKProductGovStageCategories] PRIMARY KEY CLUSTERED ([StageCategoryName] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProductGovStageCategories]
    ON [Product.Governance].[ProductGovStageCategories]([StageCategoryId] ASC);

