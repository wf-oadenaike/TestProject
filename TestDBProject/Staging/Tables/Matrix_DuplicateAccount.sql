﻿CREATE TABLE [Staging].[Matrix_DuplicateAccount] (
    [SALESFORCE_ACCOUNT_ID]            VARCHAR (18)   NOT NULL,
    [AS_AT_DATE]                       DATETIME       NOT NULL,
    [IS_PROSPECT]                      VARCHAR (1)    NULL,
    [IS_UPDATE]                        VARCHAR (1)    NULL,
    [WF_NAME]                          VARCHAR (1000) NULL,
    [WF_MATRIX_OUTLET_ID]              VARCHAR (50)   NULL,
    [WF_MATRIX_ACCOUNT_SIV_ID]         VARCHAR (100)  NULL,
    [WF_PARENT_ACCOUNT_SIV_ID]         VARCHAR (100)  NULL,
    [WF_OWNER_ID]                      VARCHAR (18)   NULL,
    [WF_OWNER_NAME]                    VARCHAR (1000) NULL,
    [WF_ACCOUNT_FSR_FRN]               INT            NULL,
    [WF_BILLING_STREET]                VARCHAR (1000) NULL,
    [WF_BILLING_CITY]                  VARCHAR (100)  NULL,
    [WF_BILLING_STATE]                 VARCHAR (100)  NULL,
    [WF_BILLING_POSTCODE]              VARCHAR (100)  NULL,
    [WF_BILLING_COUNTRY]               VARCHAR (100)  NULL,
    [WF_PHONE]                         VARCHAR (50)   NULL,
    [WF_FAX]                           VARCHAR (50)   NULL,
    [WF_WEBSITE]                       VARCHAR (128)  NULL,
    [WF_PLATFORMS_USED]                VARCHAR (1000) NULL,
    [WF_OUTLET_TYPE]                   VARCHAR (100)  NULL,
    [WF_AUTHORISATION_STATUS]          VARCHAR (1000) NULL,
    [WF_FIRM_SEGMENT]                  VARCHAR (100)  NULL,
    [WF_BILLING_STREET_2]              VARCHAR (1000) NULL,
    [WF_BILLING_STREET_3]              VARCHAR (1000) NULL,
    [WF_VERIFIED_BY]                   VARCHAR (1000) NULL,
    [WF_EXISTING_COMPANY_RELATIONSHIP] VARCHAR (1000) NULL,
    [WF_PRIORITY_FLAG]                 BIT            NULL,
    [MX_NAME]                          VARCHAR (1000) NULL,
    [MX_MATRIX_OUTLET_ID]              VARCHAR (50)   NULL,
    [MX_MATRIX_ACCOUNT_SIV_ID]         VARCHAR (100)  NULL,
    [MX_PARENT_ACCOUNT_SIV_ID]         VARCHAR (100)  NULL,
    [MX_OWNER_ID]                      VARCHAR (18)   NULL,
    [MX_OWNER_NAME]                    VARCHAR (1000) NULL,
    [MX_ACCOUNT_FSR_FRN]               INT            NULL,
    [MX_BILLINGSTREET]                 VARCHAR (1000) NULL,
    [MX_BILLINGCITY]                   VARCHAR (100)  NULL,
    [MX_BILLINGSTATE]                  VARCHAR (100)  NULL,
    [MX_POSTALCODE]                    VARCHAR (100)  NULL,
    [MX_COUNTRY]                       VARCHAR (100)  NULL,
    [MX_PHONE]                         VARCHAR (50)   NULL,
    [MX_FAX]                           VARCHAR (50)   NULL,
    [MX_WEBSITE]                       VARCHAR (128)  NULL,
    [MX_PLATFORMS_USED]                VARCHAR (1000) NULL,
    [MX_OUTLET_TYPE]                   VARCHAR (100)  NULL,
    [MX_AUTHORISATION_STATUS]          VARCHAR (1000) NULL,
    [MX_FIRM_SEGMENT]                  VARCHAR (100)  NULL,
    [MX_VERIFIED_BY]                   VARCHAR (1000) NULL,
    [MX_EXISTING_COMPANY_RELATIONSHIP] VARCHAR (1000) NULL,
    [EX_DUPLICATE_GROUP_ID]            INT            NULL,
    [FILE_NAME]                        VARCHAR (100)  NOT NULL,
    [FILE_DATE]                        DATETIME       NOT NULL,
    [FILE_TYPE]                        VARCHAR (20)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]            DATETIME       CONSTRAINT [DF_staging_Matrix_DuplicateAccount_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]             DATETIME       CONSTRAINT [DF_staging_Matrix_DuplicateAccount_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]           VARCHAR (50)   CONSTRAINT [DF_staging_Matrix_DuplicateAccount_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]            INT            CONSTRAINT [DF_staging_Matrix_DuplicateAccount_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]           ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]        DATETIME       CONSTRAINT [DF_staging_Matrix_DuplicateAccount_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__staging_Matrix_DuplicateAccount] PRIMARY KEY CLUSTERED ([SALESFORCE_ACCOUNT_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 90)
);

