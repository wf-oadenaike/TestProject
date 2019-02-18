﻿CREATE TABLE [CADIS_PROC].[DC_UPDTHWPOS_SEC_PREP] (
    [EDM_SEC_ID]                INT           NOT NULL,
    [SECURITY_NAME]             VARCHAR (100) NULL,
    [SEDOL]                     VARCHAR (7)   NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      NULL
);
