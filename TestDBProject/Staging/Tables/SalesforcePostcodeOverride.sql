CREATE TABLE [Staging].[SalesforcePostcodeOverride] (
    [SfAccountId]               VARCHAR (18)   NOT NULL,
    [AccountName]               VARCHAR (1000) NULL,
    [WFPrimaryBusiness]         VARCHAR (1000) NULL,
    [BillingStreet]             VARCHAR (1000) NULL,
    [BillingCity]               VARCHAR (100)  NULL,
    [BillingPostcode]           VARCHAR (100)  NULL,
    [AccountOwnerId]            VARCHAR (18)   NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF_SalesforcePostcodeOverride_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF_SalesforcePostcodeOverride_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)   CONSTRAINT [DF_SalesforcePostcodeOverride_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF_SalesforcePostcodeOverride_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION     NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       CONSTRAINT [DF_SalesforcePostcodeOverride_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__SalesforcePostcodeOverride] PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 90)
);

