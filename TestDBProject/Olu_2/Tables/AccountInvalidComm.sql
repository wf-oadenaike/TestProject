CREATE TABLE [Olu_2].[AccountInvalidComm] (
    [SALESFORCE_ACCOUNT_ID]     VARCHAR (18)   NOT NULL,
    [AS_AT_DATE]                DATETIME       NOT NULL,
    [WF_NAME]                   VARCHAR (1000) NULL,
    [WF_BILLING_POSTCODE]       VARCHAR (100)  NULL,
    [WF_PHONE]                  VARCHAR (50)   NULL,
    [WF_FAX]                    VARCHAR (50)   NULL,
    [FILE_NAME]                 VARCHAR (100)  NOT NULL,
    [FILE_DATE]                 DATETIME       NOT NULL,
    [FILE_TYPE]                 VARCHAR (20)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       NOT NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       NULL
);

