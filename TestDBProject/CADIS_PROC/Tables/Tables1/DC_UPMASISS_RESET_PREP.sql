CREATE TABLE [CADIS_PROC].[DC_UPMASISS_RESET_PREP] (
    [EDM_Issuer_ID]            INT           NOT NULL,
    [Issuer_Name]              BIT           NULL,
    [Ticker_exchange]          BIT           NULL,
    [Country_Of_Risk]          BIT           NULL,
    [Country_Of_Domicile]      BIT           NULL,
    [LEI]                      BIT           NULL,
    [ID_BB_GLOBAL_CO]          BIT           NULL,
    [Country_Of_Incorporation] BIT           NULL,
    [CompanyType]              BIT           NULL,
    [Salesforce_Account_Id]    BIT           NULL,
    [BoxFolderID]              BIT           NULL,
    [JiraEpicKey]              BIT           NULL,
    [PrimaryAnalystPersonID]   BIT           NULL,
    [SecondaryAnalystPersonID] BIT           NULL,
    [Currency]                 BIT           NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([EDM_Issuer_ID] ASC) WITH (FILLFACTOR = 80)
);

