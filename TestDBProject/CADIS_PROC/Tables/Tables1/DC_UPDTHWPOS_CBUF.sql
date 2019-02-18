﻿CREATE TABLE [CADIS_PROC].[DC_UPDTHWPOS_CBUF] (
    [MODEL_CODE]     VARCHAR (20) NOT NULL,
    [INSTRUMENT_UII] VARCHAR (12) NOT NULL,
    [CURRENT_DATE]   DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([MODEL_CODE] ASC, [INSTRUMENT_UII] ASC, [CURRENT_DATE] ASC) WITH (FILLFACTOR = 80)
);

