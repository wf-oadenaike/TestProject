CREATE TABLE [CADIS_PROC].[DC_ISS_UNQ_PREP] (
    [ID]                        INT           NOT NULL,
    [LegalName]                 VARCHAR (255) NOT NULL,
    [CountryID]                 INT           NULL,
    [CurrencyID]                SMALLINT      NULL,
    [SubsectorID]               SMALLINT      NULL,
    [SFAccountID]               VARCHAR (18)  NULL,
    [BoxFolderID]               VARCHAR (18)  NULL,
    [JiraEpicKey]               VARCHAR (18)  NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) NULL,
    [IsActive]                  BIT           NULL,
    [FundManagerPersonID]       SMALLINT      NULL,
    [InvestmentAnalystPersonID] SMALLINT      NULL,
    [CompanyNumber]             VARCHAR (255) NULL,
    [CompanyType]               VARCHAR (255) NULL,
    [KnownName]                 VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([LegalName] ASC) WITH (FILLFACTOR = 80)
);

