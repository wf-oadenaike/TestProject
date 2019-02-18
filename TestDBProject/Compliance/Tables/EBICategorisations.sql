CREATE TABLE [Compliance].[EBICategorisations] (
    [EBICategorisationId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EBICategorisationName] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKEBICategorisations] PRIMARY KEY CLUSTERED ([EBICategorisationId] ASC)
);

