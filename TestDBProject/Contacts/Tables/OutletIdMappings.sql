﻿CREATE TABLE [Contacts].[OutletIdMappings] (
    [OutletId]                  NVARCHAR (15) NOT NULL,
    [SalesforceAccountId]       NVARCHAR (18) NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_OIM_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_OIM_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_OIM_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_OIM_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_OIM_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKOutletIdMappings] PRIMARY KEY CLUSTERED ([OutletId] ASC)
);

