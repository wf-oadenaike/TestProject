﻿CREATE TABLE [dbo].[T_REF_ENVIRONMENT] (
    [ENTITY]                 VARCHAR (50)  NOT NULL,
    [SUB_ENTITY]             VARCHAR (100) NOT NULL,
    [ENVIRONMENT]            VARCHAR (20)  NOT NULL,
    [FOLDER]                 VARCHAR (255) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([ENTITY] ASC, [SUB_ENTITY] ASC, [ENVIRONMENT] ASC) WITH (FILLFACTOR = 90)
);

