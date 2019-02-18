CREATE TABLE [Compliance].[EBIExternalBodies] (
    [EBIExternalBodyId]          SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EBIExternalBodyDescription] VARCHAR (100) NOT NULL,
    CONSTRAINT [PKEBIExternalBodies] PRIMARY KEY CLUSTERED ([EBIExternalBodyId] ASC)
);

