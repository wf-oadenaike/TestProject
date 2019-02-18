CREATE TABLE [Core].[T_REF_Countries] (
    [ID]             INT           IDENTITY (1, 1) NOT NULL,
    [Name]           VARCHAR (255) NULL,
    [Order]          INT           NULL,
    [ISO2Code]       VARCHAR (2)   NULL,
    [ISO3Code]       VARCHAR (3)   NULL,
    [ISONumericCode] INT           NULL,
    [SalesforceID]   VARCHAR (18)  NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

