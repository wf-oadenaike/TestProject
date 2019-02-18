CREATE TABLE [CADIS_PROC].[DC_ISS_SEC_INFO_RULE] (
    [EDM_Issuer_ID]                    INT NOT NULL,
    [Issuer_Name__RULEID]              INT NULL,
    [Ticker_exchange__RULEID]          INT NULL,
    [Country_Of_Risk__RULEID]          INT NULL,
    [Country_Of_Domicile__RULEID]      INT NULL,
    [LEI__RULEID]                      INT NULL,
    [ID_BB_GLOBAL_CO__RULEID]          INT NULL,
    [Country_Of_Incorporation__RULEID] INT NULL,
    [CompanyType__RULEID]              INT NULL,
    [Salesforce_Account_Id__RULEID]    INT NULL,
    [BoxFolderID__RULEID]              INT NULL,
    [JiraEpicKey__RULEID]              INT NULL,
    [PrimaryAnalystPersonID__RULEID]   INT NULL,
    [SecondaryAnalystPersonID__RULEID] INT NULL,
    [Currency__RULEID]                 INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_Issuer_ID] ASC) WITH (FILLFACTOR = 80)
);

