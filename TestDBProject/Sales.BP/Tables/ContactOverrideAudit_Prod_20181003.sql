CREATE TABLE [Sales.BP].[ContactOverrideAudit_Prod_20181003] (
    [ContactOverrideAuditId] INT            NOT NULL,
    [AuditDate]              DATETIME       NULL,
    [AuditUser]              VARCHAR (50)   NULL,
    [sf_SfContactId]         VARCHAR (18)   NULL,
    [DataField]              VARCHAR (2000) NULL,
    [sf_SfAccountId]         VARCHAR (18)   NULL,
    [sf_LastName]            VARCHAR (200)  NULL,
    [sf_FirstName]           VARCHAR (200)  NULL,
    [sf_Value]               VARCHAR (2000) NULL,
    [mx_Value]               VARCHAR (2000) NULL,
    [Mover]                  BIT            NULL,
    [OverrideValue]          VARCHAR (2000) NULL,
    [OverrideChoice]         VARCHAR (10)   NULL,
    [OverrideStatus]         VARCHAR (10)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  NULL
);

