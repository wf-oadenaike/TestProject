﻿CREATE TABLE [CADIS].[DM_SECURITY_HUBWISE_IDG] (
    [INSTRUMENT_UII]         VARCHAR (12)  NOT NULL,
    [CADISID]                INT           NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([INSTRUMENT_UII] ASC) WITH (FILLFACTOR = 80)
);

