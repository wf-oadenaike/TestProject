CREATE TABLE [Product.Governance].[ProductGovStageSections] (
    [StageSectionId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [StageSectionName] VARCHAR (128) NOT NULL,
    CONSTRAINT [PKProductGovStageSections] PRIMARY KEY CLUSTERED ([StageSectionName] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProductGovStageSections]
    ON [Product.Governance].[ProductGovStageSections]([StageSectionId] ASC);

