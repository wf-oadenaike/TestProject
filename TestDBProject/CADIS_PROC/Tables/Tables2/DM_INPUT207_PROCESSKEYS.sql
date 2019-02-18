﻿CREATE TABLE [CADIS_PROC].[DM_INPUT207_PROCESSKEYS] (
    [MODEL_CODE]      VARCHAR (20) NOT NULL,
    [PROCESS_DATE]    DATETIME     NOT NULL,
    [INSTRUMENT_CODE] VARCHAR (12) NOT NULL,
    PRIMARY KEY CLUSTERED ([MODEL_CODE] ASC, [PROCESS_DATE] ASC, [INSTRUMENT_CODE] ASC) WITH (FILLFACTOR = 80)
);

