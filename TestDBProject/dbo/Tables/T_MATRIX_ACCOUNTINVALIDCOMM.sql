﻿CREATE TABLE [dbo].[T_MATRIX_ACCOUNTINVALIDCOMM] (
    [SALESFORCE_ACCOUNT_ID]     VARCHAR (18)   NOT NULL,
    [AS_AT_DATE]                DATETIME       NOT NULL,
    [WF_NAME]                   VARCHAR (1000) NULL,
    [WF_BILLING_POSTCODE]       VARCHAR (100)  NULL,
    [WF_PHONE]                  VARCHAR (50)   NULL,
    [WF_FAX]                    VARCHAR (50)   NULL,
    [FILE_NAME]                 VARCHAR (100)  NOT NULL,
    [FILE_DATE]                 DATETIME       NOT NULL,
    [FILE_TYPE]                 VARCHAR (20)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF_T_MATRIX_ACCOUNTINVALIDCOMM_CSI] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF_T_MATRIX_ACCOUNTINVALIDCOMM_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)   CONSTRAINT [DF_T_MATRIX_ACCOUNTINVALIDCOMM_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF_T_MATRIX_ACCOUNTINVALIDCOMM_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF_T_MATRIX_ACCOUNTINVALIDCOMM_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_MATRIX_ACCOUNTINVALIDCOMM] PRIMARY KEY CLUSTERED ([SALESFORCE_ACCOUNT_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 90)
);

