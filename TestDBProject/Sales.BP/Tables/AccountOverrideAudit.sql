CREATE TABLE [Sales.BP].[AccountOverrideAudit] (
    [AccountOverrideAuditId] INT            IDENTITY (1, 1) NOT NULL,
    [AuditDate]              DATETIME       NULL,
    [AuditUser]              VARCHAR (50)   NULL,
    [sf_SfAccountId]         VARCHAR (18)   NULL,
    [DataField]              VARCHAR (2000) NULL,
    [sf_Value]               VARCHAR (2000) NULL,
    [mx_Value]               VARCHAR (2000) NULL,
    [OverrideValue]          VARCHAR (2000) NULL,
    [OverrideChoice]         VARCHAR (10)   NULL,
    [OverrideStatus]         VARCHAR (10)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF_SBAOA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF_SBAOA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF_SBAOA_CSCB] DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([AccountOverrideAuditId] ASC)
);

