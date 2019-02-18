CREATE TABLE [dbo].[T_OVERRIDE_ISSUER_EXPIRY] (
    [EDM_Issuer_ID]            INT           NOT NULL,
    [Issuer_Name]              DATETIME      NULL,
    [Ticker_exchange]          DATETIME      NULL,
    [Country_Of_Risk]          DATETIME      NULL,
    [Country_Of_Domicile]      DATETIME      NULL,
    [LEI]                      DATETIME      NULL,
    [ID_BB_GLOBAL_CO]          DATETIME      NULL,
    [Country_Of_Incorporation] DATETIME      NULL,
    [CompanyType]              DATETIME      NULL,
    [Salesforce_Account_Id]    DATETIME      NULL,
    [BoxFolderID]              DATETIME      NULL,
    [JiraEpicKey]              DATETIME      NULL,
    [PrimaryAnalystPersonID]   DATETIME      NULL,
    [SecondaryAnalystPersonID] DATETIME      NULL,
    [Currency]                 DATETIME      NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_T_OVERRIDE_ISSUER_EXPIRY] PRIMARY KEY CLUSTERED ([EDM_Issuer_ID] ASC) WITH (FILLFACTOR = 80)
);

