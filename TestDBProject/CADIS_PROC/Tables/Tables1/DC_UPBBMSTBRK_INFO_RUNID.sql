﻿CREATE TABLE [CADIS_PROC].[DC_UPBBMSTBRK_INFO_RUNID] (
    [MASTER_BROKER_NUMBER]            VARCHAR (40) NOT NULL,
    [MASTER_BROKER_SHORT_NAME__RUNID] INT          NOT NULL,
    [MASTER_BROKER_LONG_NAME__RUNID]  INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([MASTER_BROKER_NUMBER] ASC) WITH (FILLFACTOR = 80)
);
