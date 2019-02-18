CREATE TABLE [Investment].[T_UnquotedSecurities] (
    [ID]                     INT           IDENTITY (1, 1) NOT NULL,
    [Name]                   VARCHAR (255) NOT NULL,
    [Ticker]                 VARCHAR (20)  NOT NULL,
    [IssuerID]               INT           NULL,
    [CurrencyID]             SMALLINT      NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [ACDClientID]            INT           NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

