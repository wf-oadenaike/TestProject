CREATE TABLE [CADIS_PROC].[DC_UPMASISS_NEW_PREP] (
    [Issuer_Name]              VARCHAR (250) NULL,
    [Ticker_exchange]          VARCHAR (250) NULL,
    [Country_Of_Risk]          VARCHAR (250) NULL,
    [Country_Of_Domicile]      VARCHAR (250) NULL,
    [LEI]                      VARCHAR (250) NULL,
    [ID_BB_GLOBAL_CO]          VARCHAR (250) NULL,
    [Country_Of_Incorporation] VARCHAR (4)   NULL,
    [CompanyType]              VARCHAR (250) NULL,
    [Salesforce_Account_Id]    VARCHAR (250) NULL,
    [BoxFolderID]              VARCHAR (250) NULL,
    [JiraEpicKey]              VARCHAR (250) NULL,
    [PrimaryAnalystPersonID]   SMALLINT      NULL,
    [SecondaryAnalystPersonID] SMALLINT      NULL,
    [Currency]                 VARCHAR (3)   NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) NULL
);

