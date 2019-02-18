CREATE TABLE [dbo].[T_SALESFORCE_POSTCODE_OVERRIDE_AUDIT] (
    [AuditId]                INT            IDENTITY (1, 1) NOT NULL,
    [AuditDate]              DATETIME       NULL,
    [AuditUser]              VARCHAR (50)   NULL,
    [SfAccountId]            VARCHAR (18)   NOT NULL,
    [AccountName]            VARCHAR (1000) NULL,
    [WF_PRIMARY_BUSINESS]    VARCHAR (1000) NULL,
    [BillingStreet]          VARCHAR (1000) NULL,
    [BillingCity]            VARCHAR (100)  NULL,
    [BillingPostcode]        VARCHAR (100)  NULL,
    [AccountOwnerId]         VARCHAR (18)   NULL,
    [OriginalAccountOwnerId] VARCHAR (18)   NULL,
    [OverrideStatus]         VARCHAR (10)   NULL,
    [Revert]                 BIT            NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF_T_SALESFORCE_POSTCODE_OVERRIDE_AUDIT_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF_T_SALESFORCE_POSTCODE_OVERRIDE_AUDIT_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] VARCHAR (50)   CONSTRAINT [DF_T_SALESFORCE_POSTCODE_OVERRIDE_AUDIT_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK__T_SALESFORCE_POSTCODE_OVERRIDE_AUDIT] PRIMARY KEY CLUSTERED ([AuditId] ASC) WITH (FILLFACTOR = 90)
);

