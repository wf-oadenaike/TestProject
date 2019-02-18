﻿CREATE TABLE [CADIS_PROC].[DI_INPUT175_PROCESSKEYS] (
    [CADIS_BATCH_ID]  INT NOT NULL,
    [CADIS_MSG_ID]    INT NOT NULL,
    [CADIS_PARENT_ID] INT NOT NULL,
    [CADIS_ROW_ID]    INT NOT NULL,
    PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC)
);
