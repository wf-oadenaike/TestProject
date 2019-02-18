CREATE TABLE [Sales].[DueDiligenceRequestType] (
    [TypeID]            SMALLINT      IDENTITY (1, 1) NOT NULL,
    [ClientRequestType] VARCHAR (100) NULL,
    CONSTRAINT [PK_DDRT_TypeID] PRIMARY KEY CLUSTERED ([TypeID] ASC) WITH (FILLFACTOR = 80)
);

