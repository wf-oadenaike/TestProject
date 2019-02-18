﻿CREATE TABLE [CADIS_PROC].[DC_UPPMPTY_INFO_RULE] (
    [EDM_PTY_ID]                         INT NOT NULL,
    [PARTY_SHORT_NAME__RULEID]           INT NULL,
    [PARTY_LONG_NAME__RULEID]            INT NULL,
    [PARTY_CODE__RULEID]                 INT NULL,
    [ACTIVE?__RULEID]                    INT NULL,
    [APPROVED?__RULEID]                  INT NULL,
    [PARTY_NAME__RULEID]                 INT NULL,
    [NAME_NOTES__RULEID]                 INT NULL,
    [LEGAL_NAME__RULEID]                 INT NULL,
    [BUSINESS_DESCRIPTION__RULEID]       INT NULL,
    [COMMENTS__RULEID]                   INT NULL,
    [COUNTRY_OF_DOMICILE__RULEID]        INT NULL,
    [NON_VOTING_SHARES__RULEID]          INT NULL,
    [VOTING_SHARES__RULEID]              INT NULL,
    [FED_RESERVE_MEMBER__RULEID]         INT NULL,
    [INITIAL_OPERATION_DATE__RULEID]     INT NULL,
    [COUNTRY_OF_INCORPORATION__RULEID]   INT NULL,
    [COUNTRY_OF_RISK__RULEID]            INT NULL,
    [STATE_OF_DOMICILE__RULEID]          INT NULL,
    [STATE_OF_INCORPORATION__RULEID]     INT NULL,
    [ACQUIRED_BY_PARENT__RULEID]         INT NULL,
    [TAX_HAVEN_FLAG__RULEID]             INT NULL,
    [ULTIMATE_ISSUER_ISIN__RULEID]       INT NULL,
    [REGISTRATION_NUMBER__RULEID]        INT NULL,
    [TAX_PAYER_ID__RULEID]               INT NULL,
    [REGULATORY_AUTHORITY__RULEID]       INT NULL,
    [REGULATORY_STATUS__RULEID]          INT NULL,
    [REGULATOR_ID__RULEID]               INT NULL,
    [STATUS__RULEID]                     INT NULL,
    [DISSOLUTION_DATE__RULEID]           INT NULL,
    [RED_CODE__RULEID]                   INT NULL,
    [AVOX_ID__RULEID]                    INT NULL,
    [LEI__RULEID]                        INT NULL,
    [SWIFT_BIC__RULEID]                  INT NULL,
    [BLOOMBERG_COMPANY_ID__RULEID]       INT NULL,
    [BLOOMBERG_PARENT_CO_ID__RULEID]     INT NULL,
    [BLOOMBERG_ULT_PARENT_CO_ID__RULEID] INT NULL,
    [PRIMARY_TICKER_EXCHANGE__RULEID]    INT NULL,
    [PRIMARY_TICKER__RULEID]             INT NULL,
    [DUNS_ID__RULEID]                    INT NULL,
    [SP_ENTITY_ID__RULEID]               INT NULL,
    [FITCH_ISSUER_ID__RULEID]            INT NULL,
    [SALESFORCE_ID__RULEID]              INT NULL,
    PRIMARY KEY CLUSTERED ([EDM_PTY_ID] ASC)
);

