CREATE TABLE [Core].[T_REF_Currencies] (
    [ID]       SMALLINT      IDENTITY (1, 1) NOT NULL,
    [Name]     VARCHAR (255) NOT NULL,
    [Currency] VARCHAR (255) NOT NULL,
    [ISOCode]  VARCHAR (3)   NOT NULL,
    [Symbol]   VARCHAR (10)  NOT NULL,
    [Order]    SMALLINT      NULL,
    [IsActive] SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

