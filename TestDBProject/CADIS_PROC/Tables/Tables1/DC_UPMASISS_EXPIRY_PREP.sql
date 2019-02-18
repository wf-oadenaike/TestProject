CREATE TABLE [CADIS_PROC].[DC_UPMASISS_EXPIRY_PREP] (
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
    [CADIS_SYSTEM_INSERTED]    DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([EDM_Issuer_ID] ASC) WITH (FILLFACTOR = 80)
);

