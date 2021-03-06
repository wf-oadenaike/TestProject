﻿CREATE TABLE [CADIS_PROC].[DC_ISS_INFO_RULE] (
    [EDM_ISSUER_ID]                           INT NOT NULL,
    [ID_BB_ULTIMATE_PARENT_CO_NAME__RULEID]   INT NULL,
    [ULT_PARENT_TICKER_EXCHANGE__RULEID]      INT NULL,
    [ULT_PARENT_CNTRY_OF_RISK__RULEID]        INT NULL,
    [ULT_PARENT_CNTRY_DOMICILE__RULEID]       INT NULL,
    [LEI_ULTIMATE_PARENT_COMPANY__RULEID]     INT NULL,
    [ID_BB_GLOBAL_ULTIMATE_PARENT_CO__RULEID] INT NULL,
    [ULT_PARENT_CNTRY_INCORPORATION__RULEID]  INT NULL,
    [COMPANYTYPE__RULEID]                     INT NULL,
    [SALESFORCE_ACCOUNT_ID__RULEID]           INT NULL,
    [BOXFOLDERID__RULEID]                     INT NULL,
    [FUNDMANAGERPERSONID__RULEID]             INT NULL,
    [INVESTMENTANALYSTPERSONID__RULEID]       INT NULL,
    [JIRAEPICKEY__RULEID]                     INT NULL,
    [FILE_NAME__RULEID]                       INT NULL,
    [FILE_DATE__RULEID]                       INT NULL,
    [COMPANY_NUMBER__RULEID]                  INT NULL,
    [IsActive__RULEID]                        INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_ISSUER_ID] ASC) WITH (FILLFACTOR = 80)
);

