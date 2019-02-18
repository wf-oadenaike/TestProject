﻿CREATE TABLE [dbo].[T_UNQUOTED_NEW_ISSUER] (
    [NEW_ISSUER_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [NEW_ISSUER]             VARCHAR (80)  NOT NULL,
    [SECURITY_ISO_CCY]       VARCHAR (3)   NULL,
    [TECH_STATUS]            VARCHAR (20)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([NEW_ISSUER_ID] ASC) WITH (FILLFACTOR = 80)
);

