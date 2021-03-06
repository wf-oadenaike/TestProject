﻿CREATE TABLE [dbo].[T_MASTER_COMPLIANCE_VIOL_BUCKET] (
    [CADIS_RUN_ID]           INT           NULL,
    [CADIS_PARENT_ID]        INT           NULL,
    [SECURITY_SECBOOKVAL]    VARCHAR (50)  NULL,
    [SECURITY_SECBUYSELL]    VARCHAR (50)  NULL,
    [SECURITY_SECDESC]       VARCHAR (50)  NULL,
    [SECURITY_SECIDENT]      VARCHAR (50)  NULL,
    [SECURITY_SECMKTVAL]     VARCHAR (50)  NULL,
    [SECURITY_SECPARVAL]     VARCHAR (50)  NULL,
    [SECURITY_SECPOSITION]   VARCHAR (50)  NULL,
    [SECURITY_SECPRICE]      VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           DEFAULT ((1)) NULL,
    [SECURITY_SECCURNCY]     VARCHAR (50)  NULL
);

