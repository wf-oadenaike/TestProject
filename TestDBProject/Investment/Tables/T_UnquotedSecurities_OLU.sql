CREATE TABLE [Investment].[T_UnquotedSecurities_OLU] (
    [ID]                     INT           IDENTITY (1, 1) NOT NULL,
    [Name]                   VARCHAR (255) NOT NULL,
    [Ticker]                 VARCHAR (20)  NOT NULL,
    [IssuerID]               INT           NULL,
    [CurrencyID]             SMALLINT      NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

