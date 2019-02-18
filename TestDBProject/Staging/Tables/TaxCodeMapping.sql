CREATE TABLE [Staging].[TaxCodeMapping] (
    [SageTaxCode] CHAR (3)     NOT NULL,
    [QwdTaxName]  VARCHAR (50) NOT NULL,
    CONSTRAINT [PKTaxCodeMapping] PRIMARY KEY CLUSTERED ([SageTaxCode] ASC, [QwdTaxName] ASC)
);

