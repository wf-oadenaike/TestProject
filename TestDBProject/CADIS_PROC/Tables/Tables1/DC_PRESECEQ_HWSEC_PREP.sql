﻿CREATE TABLE [CADIS_PROC].[DC_PRESECEQ_HWSEC_PREP] (
    [CADIS Id]               INT           NOT NULL,
    [INSTRUMENT_UII]         VARCHAR (12)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([CADIS Id] ASC) WITH (FILLFACTOR = 80)
);
