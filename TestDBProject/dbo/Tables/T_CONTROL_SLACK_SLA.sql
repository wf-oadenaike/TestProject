﻿CREATE TABLE [dbo].[T_CONTROL_SLACK_SLA] (
    [PLATFORM]               VARCHAR (50)  NOT NULL,
    [SOURCE]                 VARCHAR (50)  NOT NULL,
    [ENTITY]                 VARCHAR (50)  NOT NULL,
    [SUB_ENTITY]             VARCHAR (20)  NOT NULL,
    [PROCESS_STATUS]         VARCHAR (20)  NULL,
    [RECIPIENT]              VARCHAR (512) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([PLATFORM] ASC, [SOURCE] ASC, [ENTITY] ASC, [SUB_ENTITY] ASC) WITH (FILLFACTOR = 80)
);

