﻿CREATE TABLE [dbo].[T_SLA_PARAM_TEST_] (
    [ENTITY]                 VARCHAR (50)  NOT NULL,
    [RUNDATE]                DATETIME      NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([ENTITY] ASC, [RUNDATE] ASC) WITH (FILLFACTOR = 80)
);

