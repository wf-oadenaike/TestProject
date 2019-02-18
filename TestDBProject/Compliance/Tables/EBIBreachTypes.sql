CREATE TABLE [Compliance].[EBIBreachTypes] (
    [EBIBreachTypeId] SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EBIBreachName]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PKEBIBreachTypes] PRIMARY KEY CLUSTERED ([EBIBreachTypeId] ASC)
);

