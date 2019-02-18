CREATE TABLE [CADIS_PROC].[DC_ISS_SEC_INFO_RUNID] (
    [EDM_Issuer_ID]                   INT NOT NULL,
    [Issuer_Name__RUNID]              INT NOT NULL,
    [Ticker_exchange__RUNID]          INT NOT NULL,
    [Country_Of_Risk__RUNID]          INT NOT NULL,
    [Country_Of_Domicile__RUNID]      INT NOT NULL,
    [LEI__RUNID]                      INT NOT NULL,
    [ID_BB_GLOBAL_CO__RUNID]          INT NOT NULL,
    [Country_Of_Incorporation__RUNID] INT NOT NULL,
    [CompanyType__RUNID]              INT NOT NULL,
    [Salesforce_Account_Id__RUNID]    INT NOT NULL,
    [BoxFolderID__RUNID]              INT NOT NULL,
    [JiraEpicKey__RUNID]              INT NOT NULL,
    [PrimaryAnalystPersonID__RUNID]   INT NOT NULL,
    [SecondaryAnalystPersonID__RUNID] INT NOT NULL,
    [Currency__RUNID]                 INT NOT NULL,
    PRIMARY KEY CLUSTERED ([EDM_Issuer_ID] ASC) WITH (FILLFACTOR = 80)
);

