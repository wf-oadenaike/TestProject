﻿CREATE TABLE [CADIS_PROC].[DC_UPPNSTATUS_AUDIT] (
    [DATA_CHANNEL_ID]        INT            NOT NULL,
    [CADIS_SYSTEM_RUNID]     INT            NOT NULL,
    [CADIS_SYSTEM_FIELDNAME] NVARCHAR (128) NOT NULL,
    [CADIS_SYSTEM_RULEID]    INT            NULL,
    [CADIS_SYSTEM_NEWVAL]    SQL_VARIANT    NULL,
    PRIMARY KEY CLUSTERED ([DATA_CHANNEL_ID] ASC, [CADIS_SYSTEM_RUNID] ASC, [CADIS_SYSTEM_FIELDNAME] ASC) WITH (FILLFACTOR = 80)
);

