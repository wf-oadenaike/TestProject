﻿CREATE TABLE [CADIS_PROC].[DC_UPMSTPTY_INFO_VALUE] (
    [EDM_PTY_ID]                 INT             NOT NULL,
    [PARTY_SHORT_NAME]           VARCHAR (40)    NULL,
    [PARTY_LONG_NAME]            VARCHAR (40)    NULL,
    [PARTY_CODE]                 VARCHAR (40)    NULL,
    [ACTIVE?]                    BIT             NULL,
    [APPROVED?]                  BIT             NULL,
    [PARTY_NAME]                 VARCHAR (200)   NULL,
    [NAME_NOTES]                 VARCHAR (100)   NULL,
    [LEGAL_NAME]                 VARCHAR (200)   NULL,
    [BUSINESS_DESCRIPTION]       VARCHAR (MAX)   NULL,
    [COMMENTS]                   VARCHAR (MAX)   NULL,
    [COUNTRY_OF_DOMICILE]        VARCHAR (2)     NULL,
    [NON_VOTING_SHARES]          DECIMAL (38, 2) NULL,
    [VOTING_SHARES]              DECIMAL (38, 2) NULL,
    [FED_RESERVE_MEMBER]         BIT             NULL,
    [INITIAL_OPERATION_DATE]     DATETIME        NULL,
    [COUNTRY_OF_INCORPORATION]   VARCHAR (2)     NULL,
    [COUNTRY_OF_RISK]            VARCHAR (2)     NULL,
    [STATE_OF_DOMICILE]          VARCHAR (2)     NULL,
    [STATE_OF_INCORPORATION]     VARCHAR (2)     NULL,
    [ACQUIRED_BY_PARENT]         BIT             NULL,
    [TAX_HAVEN_FLAG]             BIT             NULL,
    [ULTIMATE_ISSUER_ISIN]       VARCHAR (12)    NULL,
    [REGISTRATION_NUMBER]        VARCHAR (50)    NULL,
    [TAX_PAYER_ID]               VARCHAR (50)    NULL,
    [REGULATORY_AUTHORITY]       VARCHAR (50)    NULL,
    [REGULATORY_STATUS]          VARCHAR (50)    NULL,
    [REGULATOR_ID]               VARCHAR (50)    NULL,
    [STATUS]                     VARCHAR (50)    NULL,
    [DISSOLUTION_DATE]           DATETIME        NULL,
    [RED_CODE]                   VARCHAR (50)    NULL,
    [AVOX_ID]                    INT             NULL,
    [LEI]                        VARCHAR (50)    NULL,
    [SWIFT_BIC]                  VARCHAR (50)    NULL,
    [BLOOMBERG_COMPANY_ID]       INT             NULL,
    [BLOOMBERG_PARENT_CO_ID]     INT             NULL,
    [BLOOMBERG_ULT_PARENT_CO_ID] INT             NULL,
    [PRIMARY_TICKER_EXCHANGE]    VARCHAR (50)    NULL,
    [PRIMARY_TICKER]             VARCHAR (50)    NULL,
    [DUNS_ID]                    VARCHAR (50)    NULL,
    [SP_ENTITY_ID]               VARCHAR (50)    NULL,
    [FITCH_ISSUER_ID]            VARCHAR (50)    NULL,
    [SALESFORCE_ID]              VARCHAR (50)    NULL,
    [CADIS_SYSTEM_INSERTED]      DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]       DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]     NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]      INT             DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED]  DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([EDM_PTY_ID] ASC)
);
