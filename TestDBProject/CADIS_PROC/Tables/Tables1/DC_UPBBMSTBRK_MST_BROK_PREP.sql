﻿CREATE TABLE [CADIS_PROC].[DC_UPBBMSTBRK_MST_BROK_PREP] (
    [MASTER_BROKER_NUMBER]     VARCHAR (40) NOT NULL,
    [MASTER_BROKER_SHORT_NAME] VARCHAR (40) NULL,
    [MASTER_BROKER_LONG_NAME]  VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([MASTER_BROKER_NUMBER] ASC) WITH (FILLFACTOR = 80)
);

