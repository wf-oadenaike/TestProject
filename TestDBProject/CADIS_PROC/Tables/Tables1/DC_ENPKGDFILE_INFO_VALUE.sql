﻿CREATE TABLE [CADIS_PROC].[DC_ENPKGDFILE_INFO_VALUE] (
    [TOPLEVELRUNID]          INT           NOT NULL,
    [FILE_NAME]              VARCHAR (200) NULL,
    [CLIENT]                 VARCHAR (20)  NULL,
    [ENV]                    VARCHAR (20)  NULL,
    [TIME_STAMP]             VARCHAR (20)  NULL,
    [STATUS]                 VARCHAR (20)  NULL,
    [STATUS_DECODE]          VARCHAR (20)  NULL,
    [PATH]                   VARCHAR (500) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([TOPLEVELRUNID] ASC) WITH (FILLFACTOR = 80)
);

