CREATE TABLE [Sales].[MandateTypes] (
    [MandateTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [MandateType]   VARCHAR (128) NOT NULL,
    CONSTRAINT [PKMandateTypes] PRIMARY KEY CLUSTERED ([MandateTypeId] ASC)
);

