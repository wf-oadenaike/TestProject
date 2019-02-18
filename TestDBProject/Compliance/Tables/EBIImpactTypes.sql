CREATE TABLE [Compliance].[EBIImpactTypes] (
    [EBIImpactTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EBIImpactName]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PKEBIImpactTypes] PRIMARY KEY CLUSTERED ([EBIImpactTypeId] ASC)
);

