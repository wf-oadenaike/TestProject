﻿CREATE TABLE [dbo].[T_REF_BPS_FIELD_GROUPS] (
    [FIELD_GROUP]            VARCHAR (15)  NULL,
    [ASSET_TYPE]             VARCHAR (50)  NULL,
    [SECURITY_TYP]           VARCHAR (50)  NULL,
    [FIELD_ID]               VARCHAR (50)  NULL,
    [FIELD_MNEMONIC]         VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           DEFAULT ((1)) NULL
);

