CREATE TABLE [CADIS].[CO_COLOUR] (
    [Name]           NVARCHAR (100) NOT NULL,
    [RedComponent]   TINYINT        NOT NULL,
    [GreenComponent] TINYINT        NOT NULL,
    [BlueComponent]  TINYINT        NOT NULL,
    [RGB]            AS             ((([RedComponent]*(256))*(256)+[GreenComponent]*(256))+[BlueComponent]) PERSISTED,
    CONSTRAINT [PK_CO_COLOUR] PRIMARY KEY CLUSTERED ([Name] ASC)
);

