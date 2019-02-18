﻿CREATE TABLE [Staging].[Matrix_ContactInvalidComm] (
    [SALESFORCE_CONTACT_ID]     VARCHAR (18)   NOT NULL,
    [SALESFORCE_ACCOUNT_ID]     VARCHAR (18)   NULL,
    [AS_AT_DATE]                DATETIME       NOT NULL,
    [WF_NAME]                   VARCHAR (1000) NULL,
    [WF_FIRST_NAME]             VARCHAR (1000) NULL,
    [WF_LAST_NAME]              VARCHAR (1000) NULL,
    [WF_PHONE]                  VARCHAR (50)   NULL,
    [WF_MOBILEPHONE]            VARCHAR (50)   NULL,
    [WF_FAX]                    VARCHAR (50)   NULL,
    [WF_EMAIL]                  VARCHAR (128)  NULL,
    [FILE_NAME]                 VARCHAR (100)  NOT NULL,
    [FILE_DATE]                 DATETIME       NOT NULL,
    [FILE_TYPE]                 VARCHAR (20)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF_staging_Matrix_ContactInvalidComm_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF_staging_Matrix_ContactInvalidComm_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)   CONSTRAINT [DF_staging_Matrix_ContactInvalidComm_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF_staging_Matrix_ContactInvalidComm_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF_staging_Matrix_ContactInvalidComm_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__staging_Matrix_ContactInvalidComm] PRIMARY KEY CLUSTERED ([SALESFORCE_CONTACT_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 90)
);

