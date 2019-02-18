﻿CREATE TABLE [CADIS_PROC].[DC_BACKNETFF_REF_PREP] (
    [FIELD_NAME]             VARCHAR (50)  NOT NULL,
    [SOURCE]                 VARCHAR (50)  NOT NULL,
    [SOURCE_CODE]            VARCHAR (50)  NOT NULL,
    [TARGET]                 VARCHAR (50)  NOT NULL,
    [TARGET_CODE]            VARCHAR (50)  NULL,
    [ACTIVE]                 VARCHAR (1)   NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL
);

