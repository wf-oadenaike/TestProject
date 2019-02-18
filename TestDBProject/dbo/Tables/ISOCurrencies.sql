CREATE TABLE [dbo].[ISOCurrencies] (
    [NumericCode]            SMALLINT      NOT NULL,
    [Alpha3Code]             VARCHAR (3)   NOT NULL,
    [Name]                   VARCHAR (255) NOT NULL,
    [MinorUnit]              TINYINT       NOT NULL,
    [WoodfordOrder]          SMALLINT      NOT NULL,
    [IsActive]               BIT           DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([NumericCode] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [UN_Alpha3Code] UNIQUE NONCLUSTERED ([Alpha3Code] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [UN_Name] UNIQUE NONCLUSTERED ([Name] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [UN_WoodfordOrder] UNIQUE NONCLUSTERED ([WoodfordOrder] ASC) WITH (FILLFACTOR = 80)
);

